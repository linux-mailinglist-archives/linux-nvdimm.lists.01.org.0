Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703AE1DD033
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 16:39:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E30F11572ADC;
	Thu, 21 May 2020 07:35:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A23A1003EFBE
	for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1590071944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m8VG2QgwBfpblyw8hILYr69QUKO0fYRc6Rd54EOPW8Q=;
	b=iHoAQ7QQbalQEBpi4JAMPkbMJtei92oTtm6m9B7JFwVKhaE7WZ/a2Dy//oRZEd9VHWfpcV
	hy0AkQJP239PalOOpme6dGEehiMogaMYDTO0Rvg8QKc7y/nb0cHk4gVVG420zs3ewIirfh
	sgXgTvCTR1+8gEJvIrxOCNSQv8TTaTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-PeNqcxDYOHKsxQkwu_xzYw-1; Thu, 21 May 2020 10:39:01 -0400
X-MC-Unique: PeNqcxDYOHKsxQkwu_xzYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A169106B244;
	Thu, 21 May 2020 14:39:00 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 135CC12A4D;
	Thu, 21 May 2020 14:38:58 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,  Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to override the flush barrier
References: <20200513034705.172983-1-aneesh.kumar@linux.ibm.com>
	<20200513034705.172983-3-aneesh.kumar@linux.ibm.com>
	<CAPcyv4iAdrdMiSzVr1UL9Naya+Rq70WVuKqCCNFHe1C4n+E6Tw@mail.gmail.com>
	<87v9kspk3x.fsf@linux.ibm.com>
	<CAPcyv4g+oE305Q5bYWkNBKFifB9c0TZo6+hqFQnqiFqU5QFrhQ@mail.gmail.com>
	<87d070f2vs.fsf@linux.ibm.com>
	<CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 21 May 2020 10:38:58 -0400
In-Reply-To: <CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com>
	(Dan Williams's message of "Tue, 19 May 2020 11:59:30 -0700")
Message-ID: <x49o8qh9wu5.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: JZTITTTZLFVPLJXR5ENY2JEFULVGGYBQ
X-Message-ID-Hash: JZTITTTZLFVPLJXR5ENY2JEFULVGGYBQ
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, alistair@popple.id.au, mpatocka@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JZTITTTZLFVPLJXR5ENY2JEFULVGGYBQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

>> But I agree with your concern that if we have older kernel/applications
>> that continue to use `dcbf` on future hardware we will end up
>> having issues w.r.t powerfail consistency. The plan is what you outlined
>> above as tighter ecosystem control. Considering we don't have a pmem
>> device generally available, we get both kernel and userspace upgraded
>> to use these new instructions before such a device is made available.

I thought power already supported NVDIMM-N, no?  So are you saying that
those devices will continue to work with the existing flushing and
fencing mechanisms?

> Ok, I think a compile time kernel option with a runtime override
> satisfies my concern. Does that work for you?

The compile time option only helps when running newer kernels.  I'm not
sure how you would even begin to audit userspace applications (keep in
mind, not every application is open source, and not every application
uses pmdk).  I also question the merits of forcing the administrator to
make the determination of whether all applications on the system will
work properly.  Really, you have to rely on the vendor to tell you the
platform is supported, and at that point, why put further hurdles in the
way?

The decision to require different instructions on ppc is unfortunate,
but one I'm sure we have no control over.  I don't see any merit in the
kernel disallowing MAP_SYNC access on these platforms.  Ideally, we'd
have some way of ensuring older kernels don't work with these new
platforms, but I don't think that's possible.

Moving on to the patch itself--Aneesh, have you audited other persistent
memory users in the kernel?  For example, drivers/md/dm-writecache.c does
this:

static void writecache_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
{
 	if (WC_MODE_PMEM(wc))
	        wmb(); <==========
        else
                ssd_commit_flushed(wc, wait_for_ios);
}

I believe you'll need to make modifications there.

Cheers,
Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
