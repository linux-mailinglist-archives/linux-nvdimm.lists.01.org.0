Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDDE258D3C
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Sep 2020 13:11:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E523139E77F2;
	Tue,  1 Sep 2020 04:11:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E9AF10077D17
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 04:11:18 -0700 (PDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id B6C335C5C8A95CC4DC61;
	Tue,  1 Sep 2020 19:11:15 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 19:11:10 +0800
Subject: Re: [PATCH v4 0/1] libnvdimm: fix memory leaks in of_pmem.c
To: Markus Elfring <Markus.Elfring@web.de>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20200901081450.1969-1-thunder.leizhen@huawei.com>
 <9d82bd85-5d6c-b8fe-15c7-c87348aa7a3a@web.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6a9ec7f5-f822-dce5-0560-d49d3bacaf0b@huawei.com>
Date: Tue, 1 Sep 2020 19:11:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9d82bd85-5d6c-b8fe-15c7-c87348aa7a3a@web.de>
Content-Language: en-US
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: AEDBEI6BN7WG4B73VY6ECW3XPQL4Z3OA
X-Message-ID-Hash: AEDBEI6BN7WG4B73VY6ECW3XPQL4Z3OA
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AEDBEI6BN7WG4B73VY6ECW3XPQL4Z3OA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2020/9/1 18:14, Markus Elfring wrote:
>> v3 --> v4
>> 1. Merge patch 1 and 2 into one:
> 
> How do you think about to omit a cover letter for a single patch?

After all, the code hasn't changed except this merge.

> 
> Regards,
> Markus
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
