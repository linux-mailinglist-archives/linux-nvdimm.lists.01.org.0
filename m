Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ABD190A5F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 11:14:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73A2310FC388C;
	Tue, 24 Mar 2020 03:15:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.74; helo=us-smtp-delivery-74.mimecast.com; envelope-from=bhe@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [216.205.24.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C49F510FC3194
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1585044851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2W46V6KH08v3G104dBcGJzXANovvtij5IaA5Zt56vzQ=;
	b=G5O8P1Bql1HY2fjaeNwCAX33m9lUWl9Ii48n5Hm1kUPMrYWHp7Qmnbvzqj9/3bvdEZDItk
	6MxhjxQ4fmI+KUZlktUURtjs1s2MjKM5xKHLkBRzufn/ubIIQyhbikDBOC9BAs90Rkj55o
	JBSbaklZU3Q6bXGCEXXedU6MHIXZ148=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-IKXQvLG0N9qrhjTwir3UOg-1; Tue, 24 Mar 2020 06:14:09 -0400
X-MC-Unique: IKXQvLG0N9qrhjTwir3UOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99A3F8010E8;
	Tue, 24 Mar 2020 10:14:07 +0000 (UTC)
Received: from localhost (ovpn-12-69.pek2.redhat.com [10.72.12.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EB17A19C6A;
	Tue, 24 Mar 2020 10:14:04 +0000 (UTC)
Date: Tue, 24 Mar 2020 18:14:01 +0800
From: Baoquan He <bhe@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: Re: [5.6.0-rc7] Kernel crash while running ndctl tests
Message-ID: <20200324101401.GA9942@MiWiFi-R3L-srv>
References: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
 <87a746cdva.fsf@linux.ibm.com>
 <33E32320-C371-4A41-A3E1-4B9D2DDAFBFC@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33E32320-C371-4A41-A3E1-4B9D2DDAFBFC@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: ROA5IB2FL6Q5JW4X3E3PFFYTOCOZ7HMO
X-Message-ID-Hash: ROA5IB2FL6Q5JW4X3E3PFFYTOCOZ7HMO
X-MailFrom: bhe@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ROA5IB2FL6Q5JW4X3E3PFFYTOCOZ7HMO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 03/24/20 at 03:06pm, Sachin Sant wrote:
> 
> 
> > On 24-Mar-2020, at 2:45 PM, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> wrote:
> > 
> > Sachin Sant <sachinp@linux.vnet.ibm.com> writes:
> > 
> >> While running ndctl[1] tests against 5.6.0-rc7 following crash is encountered.
> >> 
> >> Bisect leads me to  commit d41e2f3bd546 
> >> mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
> >> 
> >> Reverting this commit helps and the tests complete without any crash.
> > 
> > 
> > Can you try this change?
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index aadb7298dcef..3012d1f3771a 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -781,6 +781,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > 			ms->usage = NULL;
> > 		}
> > 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> > +		/* Mark the section invalid */
> > +		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
> > 	}
> > 
> > 	if (section_is_early && memmap)
> > 
> 
> This patch works for me. The test ran successfully without any crash/failure.

Hi Aneesh,

Could you make a formal patch to post, since Sachin has tested and
confirmed it works?

> 
> Thanks
> -Sachin
> 
> > a pfn_valid check involves pnf_section_valid() check if section is
> > having MEM_MAP. In this case we did end up  setting the ms->uage = NULL.
> > So when we do that tupdate the section to not have MEM_MAP.
> > 
> > -aneesh
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
