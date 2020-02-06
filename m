Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BF154663
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 15:43:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BDA01007A830;
	Thu,  6 Feb 2020 06:47:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 161571007A82F
	for <linux-nvdimm@lists.01.org>; Thu,  6 Feb 2020 06:46:57 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id D1614AC44;
	Thu,  6 Feb 2020 14:43:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 5E4861E0DEB; Thu,  6 Feb 2020 15:43:38 +0100 (CET)
Date: Thu, 6 Feb 2020 15:43:38 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] dax: pass NOWAIT flag to iomap_apply
Message-ID: <20200206144338.GB26114@quack2.suse.cz>
References: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
 <20200206084740.GE14001@quack2.suse.cz>
 <x49tv43lr98.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x49tv43lr98.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: DRVX37CCWNGHAV37XBQ75HUP63RJDJZY
X-Message-ID-Hash: DRVX37CCWNGHAV37XBQ75HUP63RJDJZY
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, willy@infradead.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DRVX37CCWNGHAV37XBQ75HUP63RJDJZY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu 06-02-20 09:33:39, Jeff Moyer wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Wed 05-02-20 14:15:58, Jeff Moyer wrote:
> >> fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
> >> dax".  The reason is that the initial pwrite to an empty file with the
> >> RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
> >> dax_iomap_rw doesn't pass that flag through to iomap_apply.
> >> 
> >> With this patch applied, generic/471 passes for me.
> >> 
> >> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> >
> > The patch looks good to me. You can add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > BTW, I've just noticed ext4 seems to be buggy in this regard and even this
> > patch doesn't fix it. So I guess you've been using XFS for testing this?
> 
> That's right, sorry I didn't mention that.  Will you send a patch for
> ext4, or do you want me to look into it?

I've taken down a note in todo list to eventually look into that but if you
can have a look, I'm more than happy to remove that entry :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
