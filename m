Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9536A3EA
	for <lists+linux-nvdimm@lfdr.de>; Sun, 25 Apr 2021 03:28:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 50ED4100EC1DA;
	Sat, 24 Apr 2021 18:28:34 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:5300:60:148a::1; helo=zeniv-ca.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN> 
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 24801100EC1D9
	for <linux-nvdimm@lists.01.org>; Sat, 24 Apr 2021 18:28:30 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
	id 1laTZP-0082ev-3T; Sun, 25 Apr 2021 01:28:23 +0000
Date: Sun, 25 Apr 2021 01:28:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [RFC] inconsistent semantics of _copy_mc_to_iter()
Message-ID: <YITFtxDzmIaNdseJ@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Message-ID-Hash: P5TCXBDXRLHWDRHDLJG36LNRALQAM23U
X-Message-ID-Hash: P5TCXBDXRLHWDRHDLJG36LNRALQAM23U
X-MailFrom: viro@ftp.linux.org.uk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P5TCXBDXRLHWDRHDLJG36LNRALQAM23U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

	In case of failure halfway through the operation we get
very different results depending upon the iov_iter flavour:

	iovec, pipe - advances by the amount actually copied,
	kvec, bvec - does *NOT* advance at all

Which semantics is desired?  AFAICS, the calls can be repeated -
e.g. the loop in dax_iomap_actor() will call dax_copy_to_iter()
again on the short read and with iovec-backed iter it will
try to copy from the place of failure (presumably returning 0
that time around and terminating the loop), while with bvec
or kvec it will go and paste the copies of the same chunk again
until it runs out of destination.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
