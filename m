Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9133387F4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Mar 2021 09:53:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 31587100EAB4D;
	Fri, 12 Mar 2021 00:53:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D20B8100EC1D5
	for <linux-nvdimm@lists.01.org>; Fri, 12 Mar 2021 00:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1615539208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRwrXGJxMq+pYmK820MBZhCTt+haXKGrGPdMmRxI0UE=;
	b=i9ikN8d2a8ip2lilyflcobtRR8dlVb8c7IoSajA6YOinnuWQ7iblSv9dj014SnECc2kzYO
	QJuH0vDJoAJy9EIDIfFOf9hkGGbseY4rpuBa6CUvgHfStscdwTkTpzVQgd4TbonuM0JqnT
	QsL6Qn+WqWnFJ58j7GUXJQUROKZLQBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-QlZlJlPZOFyd5hptCQo_cQ-1; Fri, 12 Mar 2021 03:53:24 -0500
X-MC-Unique: QlZlJlPZOFyd5hptCQo_cQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B4BB100C663;
	Fri, 12 Mar 2021 08:53:22 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85B4059466;
	Fri, 12 Mar 2021 08:53:10 +0000 (UTC)
Subject: Re: [RFC 0/2] virtio-pmem: Asynchronous flush
To: Dan Williams <dan.j.williams@intel.com>,
 Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
 <7e55abc4-5c91-efb8-1b32-87570dde62cc@redhat.com>
 <CALzYo33i5nBuPj4c3cJCZB9qEwfjypDqXf9vtn2wJdTYCFxg8g@mail.gmail.com>
 <CAPcyv4i4=2zT65Ym-sQv4gSa421q7FUAcX6Un3hf8=FW5qi3yw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e28be6b8-a6d4-996a-094a-830db1ab5f22@redhat.com>
Date: Fri, 12 Mar 2021 09:53:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i4=2zT65Ym-sQv4gSa421q7FUAcX6Un3hf8=FW5qi3yw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: RBLNFNAXV7FE4ZBW2KV7W2BVGTLJQO5D
X-Message-ID-Hash: RBLNFNAXV7FE4ZBW2KV7W2BVGTLJQO5D
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RBLNFNAXV7FE4ZBW2KV7W2BVGTLJQO5D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12.03.21 07:02, Dan Williams wrote:
> On Thu, Mar 11, 2021 at 8:21 PM Pankaj Gupta
> <pankaj.gupta@cloud.ionos.com> wrote:
>>
>> Hi David,
>>
>>>>    Jeff reported preflush order issue with the existing implementation
>>>>    of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
>>>>    for virtio pmem using work queue as done in md/RAID. This patch series
>>>>    intends to solve the preflush ordering issue and also makes the flush
>>>>    asynchronous from the submitting thread POV.
>>>>
>>>>    Submitting this patch series for feeback and is in WIP. I have
>>>>    done basic testing and currently doing more testing.
>>>>
>>>> Pankaj Gupta (2):
>>>>     pmem: make nvdimm_flush asynchronous
>>>>     virtio_pmem: Async virtio-pmem flush
>>>>
>>>>    drivers/nvdimm/nd_virtio.c   | 66 ++++++++++++++++++++++++++----------
>>>>    drivers/nvdimm/pmem.c        | 15 ++++----
>>>>    drivers/nvdimm/region_devs.c |  3 +-
>>>>    drivers/nvdimm/virtio_pmem.c |  9 +++++
>>>>    drivers/nvdimm/virtio_pmem.h | 12 +++++++
>>>>    5 files changed, 78 insertions(+), 27 deletions(-)
>>>>
>>>> [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
>>>>
>>>
>>> Just wondering, was there any follow up of this or are we still waiting
>>> for feedback? :)
>>
>> Thank you for bringing this up.
>>
>> My apologies I could not followup on this. I have another version in my local
>> tree but could not post it as I was not sure if I solved the problem
>> correctly. I will
>> clean it up and post for feedback as soon as I can.
>>
>> P.S: Due to serious personal/family health issues I am not able to
>> devote much time
>> on this with other professional commitments. I feel bad that I have
>> this unfinished task.
>> Just in last one year things have not been stable for me & my family
>> and still not getting :(
> 
> No worries Pankaj. Take care of yourself and your family. The
> community can handle this for you. I'm open to coaching somebody
> through what's involved to get this fix landed.

Absolutely, no need to worry for now - take care of yourself and your 
loved ones! I was merely stumbling over this series while cleaning up my 
inbox, wondering if this is still stuck waiting for review/feedback. No 
need to rush anything or be stressed.

In case I have time to look into this in the future, I'd coordinate in 
this thread (especially, asking for feedback again so I know where this 
series stands)!

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
