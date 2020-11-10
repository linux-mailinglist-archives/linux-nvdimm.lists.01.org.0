Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AAA2AD089
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Nov 2020 08:36:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9171916692873;
	Mon,  9 Nov 2020 23:36:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=yi.zhang@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B10ED165C071C
	for <linux-nvdimm@lists.01.org>; Mon,  9 Nov 2020 23:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1604993773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Fa1Qejkwu3iK7eb7mcwSsrs5GdZp4JxcinaBxm/Q54=;
	b=THn9WZF7YKG2mYJrJ6ir4gsrYz6N02YdONO7uYqGTuIQkBkXbOWJU+Ef+Ax4ipp+bV9ocT
	jWfWoikkanw6QqsxG2O4bVWxXF0JnAwp4COa4fRI1uEfl+PET8pkMvomj4It/l6y5oL/qq
	zhlFcf5N2ZWckHAh5FzQ5GtlDomAL2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-18QyPLPTNbqb0_bukc_aNA-1; Tue, 10 Nov 2020 02:36:09 -0500
X-MC-Unique: 18QyPLPTNbqb0_bukc_aNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 961611017DC8;
	Tue, 10 Nov 2020 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B5B85C1D0;
	Tue, 10 Nov 2020 07:36:06 +0000 (UTC)
Subject: Re: regression from 5.10.0-rc3: BUG: Bad page state in process
 kworker/41:0 pfn:891066 during fio on devdax
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
References: <1687234809.1086398.1604889506963.JavaMail.zimbra@redhat.com>
 <4ed7ea52-20be-68fe-f920-238ba358395c@redhat.com>
 <20201109141216.GD244516@ziepe.ca>
 <CAPcyv4gJG_-gGwzaenQdnVq13JUWLjEnsTV+e4swuVtpGVpC8g@mail.gmail.com>
 <20201109175442.GE244516@ziepe.ca> <20201110003616.GA525483@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <27b0fccb-7f71-ca99-129d-bd3e373c2a85@redhat.com>
Date: Tue, 10 Nov 2020 15:36:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201110003616.GA525483@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: F4UWU3HG7HHW2MZAT5QD3QR22XLQRHEV
X-Message-ID-Hash: F4UWU3HG7HHW2MZAT5QD3QR22XLQRHEV
X-MailFrom: yi.zhang@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F4UWU3HG7HHW2MZAT5QD3QR22XLQRHEV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 11/10/20 8:36 AM, Jason Gunthorpe wrote:
> On Mon, Nov 09, 2020 at 01:54:42PM -0400, Jason Gunthorpe wrote:
>> On Mon, Nov 09, 2020 at 09:26:19AM -0800, Dan Williams wrote:
>>> On Mon, Nov 9, 2020 at 6:12 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>> Wow, this is surprising
>>>>
>>>> This has been widely backported already, Dan please check??
>>>>
>>>> I thought pgprot_decrypted was a NOP on most x86 platforms -
>>>> sme_me_mask == 0:
>>>>
>>>> #define __sme_set(x)            ((x) | sme_me_mask)
>>>> #define __sme_clr(x)            ((x) & ~sme_me_mask)
>>>>
>>>> ??
>>>>
>>>> Confused how this can be causing DAX issues
>>> Does that correctly preserve the "soft" pte bits? Especially
>>> PTE_DEVMAP that DAX uses?
>>>
>>> I'll check...
>>   extern u64 sme_me_mask;
>>   #define __pgprot(x)		((pgprot_t) { (x) } )
>>   #define pgprot_val(x)		((x).pgprot)
>>   #define __sme_clr(x)            ((x) & ~sme_me_mask)
>>   #define pgprot_decrypted(prot)   __pgprot(__sme_clr(pgprot_val(prot)))
>>
>>   static inline int io_remap_pfn_range(struct vm_area_struct *vma,
>>                                       unsigned long addr, unsigned long pfn,
>>                                       unsigned long size, pgprot_t prot)
>>   {
>>         return remap_pfn_range(vma, addr, pfn, size, pgprot_decrypted(prot));
>>   }
>>
>> Not seeing how that could change the pgprot in any harmful way?
>>
>> Yi, are you using a platform where sme_me_mask != 0 ?
>>
>> That code looks clearly like it would only trigger on AMD SME systems,
>> is that what you are using?
> Can't be, the system is too old:
>
>   [  398.455914] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/05/2016
>
> I'm at a total loss how this change could even do anything on a
> non-AMD system, let alone how this intersects in any way with DEVDAX,
> which I could not find being used with io_remap_pfn_range()

I will double confirm it.

> How confident are you in the bisection?
>
> Jason
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
