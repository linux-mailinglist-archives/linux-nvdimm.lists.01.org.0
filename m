Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF52154642
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 15:33:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 467E71007A82E;
	Thu,  6 Feb 2020 06:37:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BCDA51007A82C
	for <linux-nvdimm@lists.01.org>; Thu,  6 Feb 2020 06:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1580999624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncPmjoEwq7PfrjChe+n1l2nRN+8/UziQd61vGlVP2YY=;
	b=eNpfm++nOWKHv8sav6wp+9ddiXu2kmwJEzeyD4Oyq0bnLcWWu48FY3Omv/yqZaOPKe9Kfg
	6so+OhfdDxeraqmwBSEU+MJBgbDD0WebJd1Q/I0CxfJ0u5Zv7feUtqxvgPzqb6H51ySTdb
	Bar1AdHS2OMQFfWFChP8kKNBS+q8Mtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-7qb4itb2PoGbLbtchBfLaw-1; Thu, 06 Feb 2020 09:33:42 -0500
X-MC-Unique: 7qb4itb2PoGbLbtchBfLaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3746C85EE82;
	Thu,  6 Feb 2020 14:33:41 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A21526FA9;
	Thu,  6 Feb 2020 14:33:40 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Jan Kara <jack@suse.cz>
Subject: Re: [patch] dax: pass NOWAIT flag to iomap_apply
References: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
	<20200206084740.GE14001@quack2.suse.cz>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 06 Feb 2020 09:33:39 -0500
In-Reply-To: <20200206084740.GE14001@quack2.suse.cz> (Jan Kara's message of
	"Thu, 6 Feb 2020 09:47:40 +0100")
Message-ID: <x49tv43lr98.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: UK7LNQEBSALKDEO66Q6MU7K4XMMZI74F
X-Message-ID-Hash: UK7LNQEBSALKDEO66Q6MU7K4XMMZI74F
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, willy@infradead.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UK7LNQEBSALKDEO66Q6MU7K4XMMZI74F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Jan Kara <jack@suse.cz> writes:

> On Wed 05-02-20 14:15:58, Jeff Moyer wrote:
>> fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
>> dax".  The reason is that the initial pwrite to an empty file with the
>> RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
>> dax_iomap_rw doesn't pass that flag through to iomap_apply.
>> 
>> With this patch applied, generic/471 passes for me.
>> 
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>
> The patch looks good to me. You can add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> BTW, I've just noticed ext4 seems to be buggy in this regard and even this
> patch doesn't fix it. So I guess you've been using XFS for testing this?

That's right, sorry I didn't mention that.  Will you send a patch for
ext4, or do you want me to look into it?

Thanks!
Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
