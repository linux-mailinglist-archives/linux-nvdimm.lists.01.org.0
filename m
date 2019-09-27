Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E545BC0473
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Sep 2019 13:38:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 76ABE21967BC5;
	Fri, 27 Sep 2019 04:40:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B0BE12010B7E4
 for <linux-nvdimm@lists.01.org>; Fri, 27 Sep 2019 04:40:49 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45763307D9CF;
 Fri, 27 Sep 2019 11:38:50 +0000 (UTC)
Received: from [10.36.116.169] (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 016791001281;
 Fri, 27 Sep 2019 11:38:48 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm/memunmap: Use the correct start and end pfn when
 removing pages from zone
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20190830091428.18399-1-david@redhat.com>
 <20190926122552.17905-1-aneesh.kumar@linux.ibm.com>
 <20190926154508.3dba3dc398b7bb9a40ba15da@linux-foundation.org>
 <894daaaf-ce64-c2d8-d246-5d4c5f42579d@linux.ibm.com>
 <e3217688-0f58-f922-01d4-f19001bb23ad@redhat.com>
 <dbaec657-db02-d721-0288-c8b8b727153d@linux.ibm.com>
 <59f15b2c-752b-68b1-30bd-f25386737a59@redhat.com>
 <28ef81f4-13dc-db4c-f911-c4eb8be575cb@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <71cdc35e-b9a5-d45f-9c02-a17eb9878da3@redhat.com>
Date: Fri, 27 Sep 2019 13:38:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <28ef81f4-13dc-db4c-f911-c4eb8be575cb@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 27 Sep 2019 11:38:50 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-mm@kvack.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 27.09.19 13:35, Aneesh Kumar K.V wrote:
> On 9/27/19 4:10 PM, David Hildenbrand wrote:
>> On 27.09.19 12:36, Aneesh Kumar K.V wrote:
>>> On 9/27/19 1:16 PM, David Hildenbrand wrote:
>>>> On 27.09.19 03:51, Aneesh Kumar K.V wrote:
>>>>> On 9/27/19 4:15 AM, Andrew Morton wrote:
>>>>>> On Thu, 26 Sep 2019 17:55:51 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>>>>>>
>>>>>>> With altmap, all the resource pfns are not initialized. While initializing
>>>>>>> pfn, altmap reserve space is skipped. Hence when removing pfn from zone skip
>>>>>>> pfns that were never initialized.
>>>>>>>
>>>>>>> Update memunmap_pages to calculate start and end pfn based on altmap
>>>>>>> values. This fixes a kernel crash that is observed when destroying namespace.
>>>>>>>
>>>>>>> [   74.745056] BUG: Unable to handle kernel data access at 0xc00c000001400000
>>>>>>> [   74.745256] Faulting instruction address: 0xc0000000000b58b0
>>>>>>> cpu 0x2: Vector: 300 (Data Access) at [c00000026ea93580]
>>>>>>>        pc: c0000000000b58b0: memset+0x68/0x104
>>>>>>>        lr: c0000000003eb008: page_init_poison+0x38/0x50
>>>>>>>        ...
>>>>>>>      current = 0xc000000271c67d80
>>>>>>>      paca    = 0xc00000003fffd680   irqmask: 0x03   irq_happened: 0x01
>>>>>>>        pid   = 3665, comm = ndctl
>>>>>>> [link register   ] c0000000003eb008 page_init_poison+0x38/0x50
>>>>>>> [c00000026ea93830] c0000000004754d4 remove_pfn_range_from_zone+0x64/0x3e0
>>>>>>> [c00000026ea938a0] c0000000004b8a60 memunmap_pages+0x300/0x400
>>>>>>> [c00000026ea93930] c0000000009e32a0 devm_action_release+0x30/0x50
>>>>>>
>>>>>> Doesn't apply to mainline or -next.  Which tree is this against?
>>>>>>
>>>>>
>>>>> After applying the patches from David on mainline. That is the reason I
>>>>> replied to this thread. I should have mentioned in the email that it is
>>>>> based on patch series "[PATCH v4 0/8] mm/memory_hotplug: Shrink zones
>>>>> before removing memory"
>>>>
>>>> So if I am not wrong, my patch "[PATCH v4 4/8] mm/memory_hotplug: Poison
>>>> memmap in remove_pfn_range_from_zone()" makes it show up that we
>>>> actually call _remove_pages() with wrong parameters, right?
>>>>
>>>> If so, I guess it would be better for you to fix it before my series and
>>>> I will rebase my series on top of that.
>>>>
>>>
>>> I posted a patch that can be applied to mainline. I sent that as a reply
>>> to this email. Can you include that and PATCH 2 as first two patches in
>>> your series?  That should help to locate the full patch series needed
>>> for fixing the kernel crash.
>>
>> I can drag these along, unless Andrew wants to pick them up right away
>> (or we're waiting for more feedback).
> 
> Considering this patch alone won't fix the issue, It would be nice if we 
> could club them with rest of the changes.
> 

I'll drag them along, adding Pankaj's RB's. If they get picked up
independently, fine :)

-- 

Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
