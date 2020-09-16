Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266C26C2D9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 14:40:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91E3214321B5F;
	Wed, 16 Sep 2020 05:40:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=richard.weiyang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8492E1214BB46
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 05:40:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U97e8cp_1600260047;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U97e8cp_1600260047)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Sep 2020 20:40:48 +0800
Date: Wed, 16 Sep 2020 20:40:47 +0800
From: Wei Yang <richard.weiyang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] kernel/resource: make iomem_resource implicit in
 release_mem_region_adjustable()
Message-ID: <20200916124047.GA47042@L-31X9LVDL-1304.local>
References: <20200911103459.10306-1-david@redhat.com>
 <20200916073041.10355-1-david@redhat.com>
 <20200916100223.GA46154@L-31X9LVDL-1304.local>
 <d11eba75-71c0-4153-944b-56e22044e0eb@redhat.com>
 <20200916121051.GA46809@L-31X9LVDL-1304.local>
 <0ee45d30-daa4-190a-2932-fb710d9496db@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ee45d30-daa4-190a-2932-fb710d9496db@redhat.com>
Message-ID-Hash: J2YLWWK7WZPAJW7ZDZAN2E6WKDIEXORQ
X-Message-ID-Hash: J2YLWWK7WZPAJW7ZDZAN2E6WKDIEXORQ
X-MailFrom: richard.weiyang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Wei Yang <richard.weiyang@linux.alibaba.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J2YLWWK7WZPAJW7ZDZAN2E6WKDIEXORQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2020 at 02:16:25PM +0200, David Hildenbrand wrote:
>On 16.09.20 14:10, Wei Yang wrote:
>> On Wed, Sep 16, 2020 at 12:03:20PM +0200, David Hildenbrand wrote:
>>> On 16.09.20 12:02, Wei Yang wrote:
>>>> On Wed, Sep 16, 2020 at 09:30:41AM +0200, David Hildenbrand wrote:
>>>>> "mem" in the name already indicates the root, similar to
>>>>> release_mem_region() and devm_request_mem_region(). Make it implicit.
>>>>> The only single caller always passes iomem_resource, other parents are
>>>>> not applicable.
>>>>>
>>>>
>>>> Looks good to me.
>>>>
>>>> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>>
>>>
>>> Thanks for the review!
>>>
>> 
>> Would you send another version? I didn't take a look into the following
>> patches, since the 4th is missed.
>
>Not planning to send another one as long as there are no further
>comments. Seems to be an issue on your side because all patches arrived
>on linux-mm (see
>https://lore.kernel.org/linux-mm/20200911103459.10306-1-david@redhat.com/)
>
>You can find patch #4 at
>https://lore.kernel.org/linux-mm/20200911103459.10306-5-david@redhat.com/
>
>(which has CC "Wei Yang <richardw.yang@linux.intel.com>")
>

Ok, I managed to apply 4th patch manually...

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
