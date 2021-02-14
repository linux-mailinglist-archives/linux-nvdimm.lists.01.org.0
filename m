Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D631B381
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Feb 2021 00:58:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EDE1B100EBB98;
	Sun, 14 Feb 2021 15:58:03 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:5300:60:148a::1; helo=zeniv-ca.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN> 
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EEC7B100EBB97
	for <linux-nvdimm@lists.01.org>; Sun, 14 Feb 2021 15:58:01 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lBRH4-00E3lo-QQ; Sun, 14 Feb 2021 23:57:58 +0000
Date: Sun, 14 Feb 2021 23:57:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Message-ID: <YCm5Bs2NalmHgeZn@zeniv-ca.linux.org.uk>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com>
 <YClQEefYBR+YKBUv@zeniv-ca.linux.org.uk>
 <20210214231456.xnwitliczv6qwmjv@intel.com>
 <YCm3NFqO9gVtXOZP@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YCm3NFqO9gVtXOZP@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Message-ID-Hash: P7OBBWKVXSEEXFAZOG6R6B3NKVVARGMD
X-Message-ID-Hash: P7OBBWKVXSEEXFAZOG6R6B3NKVVARGMD
X-MailFrom: viro@ftp.linux.org.uk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Dan Williams <dan.j.willams@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P7OBBWKVXSEEXFAZOG6R6B3NKVVARGMD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Feb 14, 2021 at 11:50:12PM +0000, Al Viro wrote:
> 	check that len is reasonable
> 	p = kmalloc(offsetof(struct foo, string[len]), GFP_KERNEL);
> 	copy_from_user(p, user_object, len);
			offsetof(struct foo, string[len]), that is
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
