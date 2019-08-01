Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD57D2EA
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Aug 2019 03:37:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 052E6212FD4F0;
	Wed, 31 Jul 2019 18:39:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=183.91.158.132;
 helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by ml01.01.org (Postfix) with ESMTP id DC58F212FD4E4
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 18:39:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; d="scan'208";a="72632467"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 01 Aug 2019 09:37:11 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
 by cn.fujitsu.com (Postfix) with ESMTP id 330514CDD99E;
 Thu,  1 Aug 2019 09:37:07 +0800 (CST)
Received: from [10.167.225.140] (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 1 Aug 2019 09:37:15 +0800
Subject: Re: [RFC PATCH 0/7] xfs: add reflink & dedupe support for fsdax.
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
References: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
 <20190731203324.7vjwlejmwpghpvqi@fiona>
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Message-ID: <800ff77a-7cd1-5fa1-fcf7-e41264a3f189@cn.fujitsu.com>
Date: Thu, 1 Aug 2019 09:37:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190731203324.7vjwlejmwpghpvqi@fiona>
Content-Language: en-US
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 330514CDD99E.AAB55
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
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
Cc: qi.fuli@fujitsu.com, gujx@cn.fujitsu.com, darrick.wong@oracle.com,
 linux-nvdimm@lists.01.org, david@fromorbit.com, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



On 8/1/19 4:33 AM, Goldwyn Rodrigues wrote:
> On 19:49 31/07, Shiyang Ruan wrote:
>> This patchset aims to take care of this issue to make reflink and dedupe
>> work correctly in XFS.
>>
>> It is based on Goldwyn's patchsets: "v4 Btrfs dax support" and "Btrfs
>> iomap".  I picked up some patches related and made a few fix to make it
>> basically works fine.
>>
>> For dax framework:
>>    1. adapt to the latest change in iomap.
>>
>> For XFS:
>>    1. report the source address and set IOMAP_COW type for those write
>>       operations that need COW.
>>    2. update extent list at the end.
>>    3. add file contents comparison function based on dax framework.
>>    4. use xfs_break_layouts() to support dax.
> 
> Shiyang,
> 
> I think you used the older patches which does not contain the iomap changes
> which would call iomap_begin() with two iomaps. I have it in the btrfs-iomap

Oh, Sorry for my carelessness.  This patchset is built on your "Btrfs 
iomap".  I didn't point it out in cover letter.

> branch and plan to update it today. It is built on v5.3-rcX, so it should
> contain the changes which moves the iomap code to the different directory.
> I will build the dax patches on top of that.
> However, we are making a big dependency chain here 
Don't worry.  It's fine for me.  I'll follow your updates.

> 

-- 
Thanks,
Shiyang Ruan.


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
