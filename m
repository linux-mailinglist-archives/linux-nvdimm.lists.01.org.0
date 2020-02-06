Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E615415483B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 16:40:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7FC8B1007A84C;
	Thu,  6 Feb 2020 07:43:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D4C61007A831
	for <linux-nvdimm@lists.01.org>; Thu,  6 Feb 2020 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581003597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYOYGUmwnwR/sxALNyTmJEU8tjH1tqXxiHmaN9nBtbg=;
	b=ZjzLOh9EJ2zL/wQz+7OJN7EjnBs7pgXdIhd003kEwLwcPhFWub24KuHVnXf5PtNV08u1gJ
	qj9fDYlKWVQvm/d7+ShGN8lR8GKj9+W96kAs1xCRGeNH8Iw+bWahMGIhkUDIzDkEILt+Mf
	/O5HNqB7Wr2MO/fW9qk7dNmqM3y0Dcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-W7fKFVbAO-mVmHC7HOWqXg-1; Thu, 06 Feb 2020 10:39:50 -0500
X-MC-Unique: W7fKFVbAO-mVmHC7HOWqXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85C7010054E3;
	Thu,  6 Feb 2020 15:39:49 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E35AE857BF;
	Thu,  6 Feb 2020 15:39:48 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Jan Kara <jack@suse.cz>
Subject: Re: [patch] dax: pass NOWAIT flag to iomap_apply
References: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
	<20200206084740.GE14001@quack2.suse.cz>
	<x49tv43lr98.fsf@segfault.boston.devel.redhat.com>
	<20200206144338.GB26114@quack2.suse.cz>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 06 Feb 2020 10:39:47 -0500
In-Reply-To: <20200206144338.GB26114@quack2.suse.cz> (Jan Kara's message of
	"Thu, 6 Feb 2020 15:43:38 +0100")
Message-ID: <x49ftfnlo70.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: AAGCNYOOENEGOGK2TLPHGFE6TR2OLQKN
X-Message-ID-Hash: AAGCNYOOENEGOGK2TLPHGFE6TR2OLQKN
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, willy@infradead.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AAGCNYOOENEGOGK2TLPHGFE6TR2OLQKN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Jan Kara <jack@suse.cz> writes:

> On Thu 06-02-20 09:33:39, Jeff Moyer wrote:
>> Jan Kara <jack@suse.cz> writes:
>> 
>> > On Wed 05-02-20 14:15:58, Jeff Moyer wrote:
>> >> fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
>> >> dax".  The reason is that the initial pwrite to an empty file with the
>> >> RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
>> >> dax_iomap_rw doesn't pass that flag through to iomap_apply.
>> >> 
>> >> With this patch applied, generic/471 passes for me.
>> >> 
>> >> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>> >
>> > The patch looks good to me. You can add:
>> >
>> > Reviewed-by: Jan Kara <jack@suse.cz>
>> >
>> > BTW, I've just noticed ext4 seems to be buggy in this regard and even this
>> > patch doesn't fix it. So I guess you've been using XFS for testing this?
>> 
>> That's right, sorry I didn't mention that.  Will you send a patch for
>> ext4, or do you want me to look into it?
>
> I've taken down a note in todo list to eventually look into that but if you
> can have a look, I'm more than happy to remove that entry :).

OK, I'll take a look.

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
