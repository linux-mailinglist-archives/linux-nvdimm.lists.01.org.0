Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69524A18B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 16:18:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63AF51342F389;
	Wed, 19 Aug 2020 07:18:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 487E11342F387
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 07:18:31 -0700 (PDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 8908AB40B7E2DEBD118D;
	Wed, 19 Aug 2020 22:18:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 22:18:24 +0800
Subject: Re: [PATCH v2 1/4] libnvdimm: Fix memory leaks in of_pmem.c
To: Oliver O'Halloran <oohall@gmail.com>, Markus Elfring
	<Markus.Elfring@web.de>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-2-thunder.leizhen@huawei.com>
 <5cc26ce3-963e-3ab6-6f97-706cea00c5f3@web.de>
 <CAOSf1CGJ6JNBuN+EpLttpf0HYOtN8dpqoTscGYHEbxqb9ANkVg@mail.gmail.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <aacaa4e4-95c9-c089-dea0-6a7c4808d1ea@huawei.com>
Date: Wed, 19 Aug 2020 22:18:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOSf1CGJ6JNBuN+EpLttpf0HYOtN8dpqoTscGYHEbxqb9ANkVg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: CUJPQ7TROP25BSXU2N2S3UOUKNVH7LQW
X-Message-ID-Hash: CUJPQ7TROP25BSXU2N2S3UOUKNVH7LQW
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CUJPQ7TROP25BSXU2N2S3UOUKNVH7LQW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 8/19/2020 9:35 PM, Oliver O'Halloran wrote:
> On Wed, Aug 19, 2020 at 10:28 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>>
>>> The memory priv->bus_desc.provider_name allocated by kstrdup() is not
>>> freed correctly.
> 
> Personally I thought his commit message was perfectly fine. A little
> unorthodox, but it works.
> 
>> How do you think about to choose an imperative wording for
>> a corresponding change description?
> 
> ...but this! This is word salad.

Talented students are trained by strict teacher. All of us is trying to make things better.

> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=18445bf405cb331117bc98427b1ba6f12418ad17#n151
>>
>> Regards,
>> Markus
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
