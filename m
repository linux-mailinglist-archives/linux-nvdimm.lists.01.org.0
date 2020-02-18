Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8061630A2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 20:51:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3171F10FC33FD;
	Tue, 18 Feb 2020 11:51:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C462510FC33E7
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582055457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+LV8qrLkLKxHNwn2AaZxB78FQ7KCDxReRpoihQjkh4=;
	b=HWxmiD0rD8SEe+AH5TdLMJtiliYwprfImQM1tX6UJ++rjAGfD3Dcp/DFbCQk6rZ9GPIRfd
	l9E/k0T3eFo2G5X8hsoUJpzRZZUtDoRmLiXB0gL9+blkMIQQy1NhWxb354uWQS+XIfHPod
	aw2nsbPUZd4qe7x0rC7UcuaGtZh9AUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-aS0ax9IXOAmCjVPDxzFEnw-1; Tue, 18 Feb 2020 14:50:52 -0500
X-MC-Unique: aS0ax9IXOAmCjVPDxzFEnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F37F10509B8;
	Tue, 18 Feb 2020 19:50:51 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 974031001920;
	Tue, 18 Feb 2020 19:50:50 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH] dax: Do not try to clear poison for partial pages
References: <20200129210337.GA13630@redhat.com>
	<f97d1ce2-9003-6b46-cd25-a908dc3bd2c6@oracle.com>
	<CAPcyv4ittXHkEV4eH_4F5vCfwRLoTTtDqEU1SmCs5DYUdZxBOA@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 18 Feb 2020 14:50:49 -0500
In-Reply-To: <CAPcyv4ittXHkEV4eH_4F5vCfwRLoTTtDqEU1SmCs5DYUdZxBOA@mail.gmail.com>
	(Dan Williams's message of "Wed, 5 Feb 2020 16:37:40 -0800")
Message-ID: <x49v9o3brom.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: 6MXVSRRUYIIULT2WXEXIV4CGELSREP3I
X-Message-ID-Hash: 6MXVSRRUYIIULT2WXEXIV4CGELSREP3I
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6MXVSRRUYIIULT2WXEXIV4CGELSREP3I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> Right now the kernel does not install a pte on faults that land on a
> page with known poison, but only because the error clearing path is so
> convoluted and could only claim that fallocate(PUNCH_HOLE) cleared
> errors because that was guaranteed to send 512-byte aligned zero's
> down the block-I/O path when the fs-blocks got reallocated. In a world
> where native cpu instructions can clear errors the dax write() syscall
> case could be covered (modulo 64-byte alignment), and the kernel could
> just let the page be mapped so that the application could attempt it's
> own fine-grained clearing without calling back into the kernel.

I'm not sure we'd want to do allow mapping the PTEs even if there was
support for clearing errors via CPU instructions.  Any load from a
poisoned page will result in an MCE, and there exists the possiblity
that you will hit an unrecoverable error (Processor Context Corrupt).
It's just safer to catch these cases by not mapping the page, and
forcing recovery through the driver.

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
