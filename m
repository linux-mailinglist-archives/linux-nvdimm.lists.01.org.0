Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E4A1802E
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 21:05:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DAED22122C312;
	Wed,  8 May 2019 12:05:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=jstaron@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 174542121797E
 for <linux-nvdimm@lists.01.org>; Wed,  8 May 2019 12:05:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t22so10540469pgi.10
 for <linux-nvdimm@lists.01.org>; Wed, 08 May 2019 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xx1nBdwm/fMIaQ+XRMTVvJx4homKW8vOYVCrjJQah8c=;
 b=u2CwdPBWUhvunu491lhDVH7O10yitnzRdNYTDcNKNGaaMw+pYsmkpn0J9MsT99d39Y
 Q/Wk7PGyXcjoc1tha4UuyE89T0rOnD72kAWNnjYRKkjCa0DELX1ElQVVB5fGF3jmFGkX
 uLZw9HuRYb+PEeZ/PPFrro1K3Iw9vCnd+ELZuZL2OKCDNAb8u9QKbTbbytR8kbwE4FBI
 Zo/dlYVRRbaMO0EpBIfmHWL9EiKzdxDQc7t8r9e2EKWR9k2JLXoh6H4LfMbZMUTXsaF+
 muQoMtmzSSBP8hE/rlSXFu27Me96rPxVPBbMGgvYpGy27lg+hjZKYMbf9BMngu5WO2ck
 kXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xx1nBdwm/fMIaQ+XRMTVvJx4homKW8vOYVCrjJQah8c=;
 b=TauZ9Cd5p4SZYGXUw4eBuGDyQEtiZYLAMyZh5H5mGkiX46Vbc/rmOvo8vFLfRkbh5K
 LJcrvz12cdQUykJVwAG6/+VMHBQsynG6yWqLcizYbupt5YUYlhjv7DocfYQ2mJMr/d1P
 MSpynioj44BvKZls4790ULexIcSq2IxQ2grdN0x5+UJ+KmRg3zDMeCP5BNuyPv4wyGFm
 dCMGrmmA9QtKgGVMgA+Y/N/hbpg0/F2bX/OtuLua88/MKEDQ2R126n52z89m1l/+fX++
 iP79kA44dvmfxV6KwflTe2BLZ+t5D9obPFpaj2nh3/YmCfRDnyiCK/7BJYSFiCvPOgWe
 LloA==
X-Gm-Message-State: APjAAAWPFUwDsCtn5FsK6L9hxEOBjfdqp30q8m+Ugy6UhC7y2dmhk+EO
 QC95bFacgDNJfwf2WuSjzlgfMw==
X-Google-Smtp-Source: APXvYqzypNLQt7uc54cFtZOQcJp0DaX+ClanYsAzKwneRj68EqOnfHTAe97HizrDj+ZvHjUmPOl5NA==
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr47363166pgt.36.1557342342253; 
 Wed, 08 May 2019 12:05:42 -0700 (PDT)
Received: from jstaron2.mtv.corp.google.com
 ([2620:15c:202:201:b94f:2527:c39f:ca2d])
 by smtp.gmail.com with ESMTPSA id 129sm23470533pff.140.2019.05.08.12.05.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 May 2019 12:05:41 -0700 (PDT)
From: =?UTF-8?Q?Jakub_Staro=c5=84?= <jstaron@google.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/6] virtio-pmem: Add virtio pmem driver
To: Pankaj Gupta <pagupta@redhat.com>
References: <20190426050039.17460-1-pagupta@redhat.com>
 <20190426050039.17460-3-pagupta@redhat.com>
 <3d6479ae-6c39-d614-f1d9-aa1978e2e438@google.com>
 <1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
Message-ID: <3d643ac5-ea1b-efba-9f42-31b2ed3ab5b0@google.com>
Date: Wed, 8 May 2019 12:05:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
Content-Language: en-US
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 adilger kernel <adilger.kernel@dilger.ca>, smbarber@google.com,
 zwisler@kernel.org, aarcange@redhat.com, linux-nvdimm@lists.01.org,
 david@redhat.com, willy@infradead.org, hch@infradead.org,
 linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, lenb@kernel.org,
 kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
 stefanha@redhat.com, imammedo@redhat.com, lcapitulino@redhat.com,
 kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
 darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/8/19 4:12 AM, Pankaj Gupta wrote:
> 
>>
>> On 4/25/19 10:00 PM, Pankaj Gupta wrote:
>>
>>> +void host_ack(struct virtqueue *vq)
>>> +{
>>> +	unsigned int len;
>>> +	unsigned long flags;
>>> +	struct virtio_pmem_request *req, *req_buf;
>>> +	struct virtio_pmem *vpmem = vq->vdev->priv;
>>> +
>>> +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
>>> +	while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
>>> +		req->done = true;
>>> +		wake_up(&req->host_acked);
>>> +
>>> +		if (!list_empty(&vpmem->req_list)) {
>>> +			req_buf = list_first_entry(&vpmem->req_list,
>>> +					struct virtio_pmem_request, list);
>>> +			list_del(&vpmem->req_list);
>>
>> Shouldn't it be rather `list_del(vpmem->req_list.next)`? We are trying to
>> unlink
>> first element of the list and `vpmem->req_list` is just the list head.
> 
> This looks correct. We are not deleting head but first entry in 'req_list'
> which is device corresponding list of pending requests.
> 
> Please see below:
> 
> /**
>  * Retrieve the first list entry for the given list pointer.
>  *
>  * Example:
>  * struct foo *first;
>  * first = list_first_entry(&bar->list_of_foos, struct foo, list_of_foos);
>  *
>  * @param ptr The list head
>  * @param type Data type of the list element to retrieve
>  * @param member Member name of the struct list_head field in the list element.
>  * @return A pointer to the first list element.
>  */
> #define list_first_entry(ptr, type, member) \
>     list_entry((ptr)->next, type, member)

Please look at this StackOverflow question:
https://stackoverflow.com/questions/19675419/deleting-first-element-of-a-list-h-list

Author asks about deleting first element of the queue. In our case
(and also in the question's author case), `vpmem->req_list` is not element
of any request struct and not an element of the list. It's just a list head storing 
`next` and `prev` pointers which are then pointing to respectively first and
last element of the list. We want to unlink the first element of the list,
so we need to pass pointer to the first element of the list to
the `list_del` function - that is, the `vpmem->req_list.next`.

Thank you,
Jakub Staron
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
