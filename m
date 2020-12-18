Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960492DDE4B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 07:02:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B75E8100EB327;
	Thu, 17 Dec 2020 22:02:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85C3E100EB859
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 22:02:13 -0800 (PST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cxyt204T3zhttS;
	Fri, 18 Dec 2020 14:01:30 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Fri, 18 Dec 2020
 14:02:03 +0800
Subject: Re: [PATCH 1/1] device-dax: avoid an unnecessary check in
 alloc_dev_dax_range()
To: Dan Williams <dan.j.williams@intel.com>
References: <20201120092251.2197-1-thunder.leizhen@huawei.com>
 <CAPcyv4jxgbawSbYF39g857fiDCRmMACr1u-OiSWkz4M0+2UPbQ@mail.gmail.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <946f9111-f799-38a1-a185-d882668fa725@huawei.com>
Date: Fri, 18 Dec 2020 14:02:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jxgbawSbYF39g857fiDCRmMACr1u-OiSWkz4M0+2UPbQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Message-ID-Hash: TBZNMMC7KYX6AB7MWJDWUMSTSV4HZOVP
X-Message-ID-Hash: TBZNMMC7KYX6AB7MWJDWUMSTSV4HZOVP
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TBZNMMC7KYX6AB7MWJDWUMSTSV4HZOVP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2020/12/18 11:10, Dan Williams wrote:
> On Fri, Nov 20, 2020 at 1:23 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> Swap the calling sequence of krealloc() and __request_region(), call the
>> latter first. In this way, the value of dev_dax->nr_range does not need to
>> be considered when __request_region() failed.
> 
> This looks ok, but I think I want to see another cleanup go in first
> before this to add a helper for trimming the last range off the set of
> ranges:
> 
> static void dev_dax_trim_range(struct dev_dax *dev_dax)
> {
>         int i = dev_dax->nr_range - 1;
>         struct range *range = &dev_dax->ranges[i].range;
>         struct dax_region *dax_region = dev_dax->region;
> 
>         dev_dbg(dev, "delete range[%d]: %#llx:%#llx\n", i,
>                 (unsigned long long)range->start,
>                 (unsigned long long)range->end);
> 
>         __release_region(&dax_region->res, range->start, range_len(range));
>         if (--dev_dax->nr_range == 0) {
>                 kfree(dev_dax->ranges);
>                 dev_dax->ranges = NULL;
>         }
> }
> 
> Care to do a lead in patch with that cleanup, then do this one?

I don't mind! You can add above helper first. After that, I'll update
and send this patch again.

> 
> I think that might also cleanup a memory leak report from Jane in
> addition to not needing the "goto" as well.
> 
> http://lore.kernel.org/r/c8a8a260-34c6-dbfc-1f19-25c23d01cb45@oracle.com
> 
> .
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
