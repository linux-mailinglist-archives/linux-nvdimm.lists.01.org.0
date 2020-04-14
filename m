Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D85271A886B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Apr 2020 20:04:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFA6F10FC546A;
	Tue, 14 Apr 2020 11:04:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8ACF610FC51D2
	for <linux-nvdimm@lists.01.org>; Tue, 14 Apr 2020 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1586887438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rx2Ril4IhcGbOSEgAufyr9smW8KicvIgR4/6kMVt74I=;
	b=e5gsTXcd9dlBtuG6VKEZVrK57kfuC+l9X5It9VvkkdQdBMwLUrB88FbIMZzHckzn4N7r5S
	NlXLIET8LCGrKrme7rP+1ZRb3vAhMw2SV7yS4Grv4HiHn6nVcWExQwRIo+lg1tUTmVOrMz
	pxnbwhyt7YpCFz/BtQShZ2na2N1EUmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-WPJjWnPxNVaFY7i-EnO2dQ-1; Tue, 14 Apr 2020 14:03:55 -0400
X-MC-Unique: WPJjWnPxNVaFY7i-EnO2dQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE230107ACC7;
	Tue, 14 Apr 2020 18:03:53 +0000 (UTC)
Received: from [10.36.113.201] (ovpn-113-201.ams2.redhat.com [10.36.113.201])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5524C1001902;
	Tue, 14 Apr 2020 18:03:52 +0000 (UTC)
Subject: Re: [PATCH] dax/kmem: refrain from adding memory into an impossible
 node
To: Dan Williams <dan.j.williams@intel.com>
References: <20200411000916.13656-1-vishal.l.verma@intel.com>
 <15dbb4ab-9d23-3b0d-99a1-1286ecca8e7b@redhat.com>
 <CAPcyv4hWsmv=UQ3i7XOZpQLEMrfWniMvnrxU18UB1Oj=A_yScw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <642c7805-0fe3-6a0a-00f2-d6cfcc4dfe74@redhat.com>
Date: Tue, 14 Apr 2020 20:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hWsmv=UQ3i7XOZpQLEMrfWniMvnrxU18UB1Oj=A_yScw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: SRHABLOMCIFSE7BVQE5HRD2WEHUEXPXQ
X-Message-ID-Hash: SRHABLOMCIFSE7BVQE5HRD2WEHUEXPXQ
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SRHABLOMCIFSE7BVQE5HRD2WEHUEXPXQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14.04.20 19:58, Dan Williams wrote:
> On Tue, Apr 14, 2020 at 4:51 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 11.04.20 02:09, Vishal Verma wrote:
>>> A misbehaving qemu created a situation where the ACPI SRAT table
>>> advertised one fewer proximity domains than intended. The NFIT table did
>>> describe all the expected proximity domains. This caused the device dax
>>> driver to assign an impossible target_node to the device, and when
>>> hotplugged as system memory, this would fail with the following
>>> signature:
>>>
>>>   [  +0.001627] BUG: kernel NULL pointer dereference, address: 0000000000000088
>>>   [  +0.001331] #PF: supervisor read access in kernel mode
>>>   [  +0.000975] #PF: error_code(0x0000) - not-present page
>>>   [  +0.000976] PGD 80000001767d4067 P4D 80000001767d4067 PUD 10e0c4067 PMD 0
>>>   [  +0.001338] Oops: 0000 [#1] SMP PTI
>>>   [  +0.000676] CPU: 4 PID: 22737 Comm: kswapd3 Tainted: G           O      5.6.0-rc5 #9
>>>   [  +0.001457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>>>       BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>>>   [  +0.001990] RIP: 0010:prepare_kswapd_sleep+0x7c/0xc0
>>>   [  +0.000780] Code: 89 df e8 87 fd ff ff 89 c2 31 c0 84 d2 74 e6 0f 1f 44
>>>                       00 00 48 8b 05 fb af 7a 01 48 63 93 88 1d 01 00 48 8b
>>>                     84 d0 20 0f 00 00 <48> 3b 98 88 00 00 00 75 28 f0 80 a0
>>>                     80 00 00 00 fe f0 80 a3 38 20
>>>   [  +0.002877] RSP: 0018:ffffc900017a3e78 EFLAGS: 00010202
>>>   [  +0.000805] RAX: 0000000000000000 RBX: ffff8881209e0000 RCX: 0000000000000000
>>>   [  +0.001115] RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff8881209e0e80
>>>   [  +0.001098] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000008000
>>>   [  +0.001092] R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000003
>>>   [  +0.001092] R13: 0000000000000003 R14: 0000000000000000 R15: ffffc900017a3ec8
>>>   [  +0.001091] FS:  0000000000000000(0000) GS:ffff888318c00000(0000) knlGS:0000000000000000
>>>   [  +0.001275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>   [  +0.000882] CR2: 0000000000000088 CR3: 0000000120b50002 CR4: 00000000001606e0
>>>   [  +0.001095] Call Trace:
>>>   [  +0.000388]  kswapd+0x103/0x520
>>>   [  +0.000494]  ? finish_wait+0x80/0x80
>>>   [  +0.000547]  ? balance_pgdat+0x5a0/0x5a0
>>>   [  +0.000607]  kthread+0x120/0x140
>>>   [  +0.000508]  ? kthread_create_on_node+0x60/0x60
>>>   [  +0.000706]  ret_from_fork+0x3a/0x50
>>>
>>> Add a check in the kmem driver to ensure that the target_node for the
>>> device in question is in the nodes_possible mask.
>>>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
>>> ---
>>>  drivers/dax/kmem.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>> index 3d0a7e702c94..760c5b4e88c8 100644
>>> --- a/drivers/dax/kmem.c
>>> +++ b/drivers/dax/kmem.c
>>> @@ -32,7 +32,7 @@ int dev_dax_kmem_probe(struct device *dev)
>>>        * unavoidable performance issues.
>>>        */
>>>       numa_node = dev_dax->target_node;
>>> -     if (numa_node < 0) {
>>> +     if (numa_node < 0 || !node_possible(numa_node)) {
>>>               dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
>>>                        res, numa_node);
>>>               return -EINVAL;
>>>
>>
>> I do wonder if we should reject that from
>> add_memory()..->add_memory_resource() instead, where we do the
>> __try_online_node().
> 
> Yes, makes sense to centralize that check internal to
> add_memory_resource(). However, instead of a failure let's just pick
> the next "closest" possible node with a firmware-workaround
> taint-warning to let the admin know when their added memory has an
> awkward numa node, but otherwise let the memory come online.
> 

With a warning, this makes sense.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
