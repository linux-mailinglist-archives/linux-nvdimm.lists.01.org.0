Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C703025B20E
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Sep 2020 18:51:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED72C13AA0E4F;
	Wed,  2 Sep 2020 09:51:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=msnitzer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A77413AA0DC8
	for <linux-nvdimm@lists.01.org>; Wed,  2 Sep 2020 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599065469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74mQ9Eft5Oqc5DcO1+gghJFJ0GFEHzOiz6OhhJwC3w4=;
	b=DonuvwqfEtr+EcorDNcR9TvKOgtog7ZoD+b/exR5tg9vP6H2eJf+UxDSzIZDpPOzzi2gIm
	som63sws+K+JgeIeWi0KSQ9TwwcDf7orjXeBF5/S5DkIxNXZ1Xa2kzFONu++oolLL7Ifqo
	t9jYksVHRdRJldcIJKDjThTg/H0fYbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-5DgQMLDtMve93lBb9SBLFg-1; Wed, 02 Sep 2020 12:51:07 -0400
X-MC-Unique: 5DgQMLDtMve93lBb9SBLFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5951802B76;
	Wed,  2 Sep 2020 16:51:05 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B0487B28;
	Wed,  2 Sep 2020 16:51:01 +0000 (UTC)
Date: Wed, 2 Sep 2020 12:51:01 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Coly Li <colyli@suse.de>
Subject: Re: flood of "dm-X: error: dax access failed" due to 5.9 commit
 231609785cbfb
Message-ID: <20200902165101.GB5928@redhat.com>
References: <20200902160432.GA5513@redhat.com>
 <df0203fa-7f75-53ac-8bf1-79a1c861918e@suse.de>
 <20200902164456.GA5928@redhat.com>
 <4968af50-663d-74cf-1be2-aaed48a380d5@suse.de>
MIME-Version: 1.0
In-Reply-To: <4968af50-663d-74cf-1be2-aaed48a380d5@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Message-ID-Hash: UMV4OL7AKATL75CEYQ4ZBZU5Y6Y3MDPK
X-Message-ID-Hash: UMV4OL7AKATL75CEYQ4ZBZU5Y6Y3MDPK
X-MailFrom: msnitzer@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, linux-nvdimm@lists.01.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UMV4OL7AKATL75CEYQ4ZBZU5Y6Y3MDPK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 02 2020 at 12:46pm -0400,
Coly Li <colyli@suse.de> wrote:

> On 2020/9/3 00:44, Mike Snitzer wrote:
> > On Wed, Sep 02 2020 at 12:40pm -0400,
> > Coly Li <colyli@suse.de> wrote:
> > 
> >> On 2020/9/3 00:04, Mike Snitzer wrote:
> >>> 5.9 commit 231609785cbfb ("dax: print error message by pr_info() in
> >>> __generic_fsdax_supported()") switched from pr_debug() to pr_info().
> >>>
> >>> The justification in the commit header is really inadequate.  If there
> >>> is a problem that you need to drill in on, repeat the testing after
> >>> enabling the dynamic debugging.
> >>>
> >>> Otherwise, now all DM devices that aren't layered on DAX capable devices
> >>> spew really confusing noise to users when they simply activate their
> >>> non-DAX DM devices:
> >>>
> >>> [66567.129798] dm-6: error: dax access failed (-5)
> >>> [66567.134400] dm-6: error: dax access failed (-5)
> >>> [66567.139152] dm-6: error: dax access failed (-5)
> >>> [66567.314546] dm-2: error: dax access failed (-95)
> >>> [66567.319380] dm-2: error: dax access failed (-95)
> >>> [66567.324254] dm-2: error: dax access failed (-95)
> >>> [66567.479025] dm-2: error: dax access failed (-95)
> >>> [66567.483713] dm-2: error: dax access failed (-95)
> >>> [66567.488722] dm-2: error: dax access failed (-95)
> >>> [66567.494061] dm-2: error: dax access failed (-95)
> >>> [66567.498823] dm-2: error: dax access failed (-95)
> >>> [66567.503693] dm-2: error: dax access failed (-95)
> >>>
> >>> commit 231609785cbfb must be reverted.
> >>>
> >>> Please advise, thanks.
> >>
> >> Adrian Huang from Lenovo posted a patch, which titled: dax: do not print
> >> error message for non-persistent memory block device
> >>
> >> It fixes the issue, but no response for now. Maybe we should take this fix.
> > 
> > OK, yes sounds like it.  It was merged and is commit c2affe920b0e066
> > ("dax: do not print error message for non-persistent memory block
> > device")
> 
> Thanks for informing me this patch is merged, I am going to update my
> local one :-)

So the thing is I'm running v5.9-rc3 (which includes this commit) but
I'm still seeing all these warnings when I run the lvm2 testsuite.  The
reason _seems_ to be because the lvm2 testsuite uses brd devices for
test devices.  So there is something about the brd device that shows
commit c2affe920b0e066 isn't enough :(

Mike
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
