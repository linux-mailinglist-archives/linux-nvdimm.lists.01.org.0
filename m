Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 037DFEAA01
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 05:55:08 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7769D100EA55F;
	Wed, 30 Oct 2019 21:55:31 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 852DF100EA554
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 21:55:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.68,250,1569254400";
   d="scan'208";a="77722261"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Oct 2019 12:54:57 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id 7B345486A852;
	Thu, 31 Oct 2019 12:46:58 +0800 (CST)
Received: from [10.167.225.140] (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 31 Oct 2019 12:55:08 +0800
Subject: Re: [RFC PATCH v2 0/7] xfs: reflink & dedupe for fsdax (read/write
 path).
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
References: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com>
 <20191030114818.emvmgfgqadiqintw@fiona>
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Message-ID: <2737c6f6-5cca-2b92-edff-fb9227ccc6d1@cn.fujitsu.com>
Date: Thu, 31 Oct 2019 12:54:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20191030114818.emvmgfgqadiqintw@fiona>
Content-Language: en-US
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 7B345486A852.A9538
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: HUJSSJVQMG2HNRO5UTMOKPZU4JHRS4LD
X-Message-ID-Hash: HUJSSJVQMG2HNRO5UTMOKPZU4JHRS4LD
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, darrick.wong@oracle.com, hch@infradead.org, david@fromorbit.com, linux-kernel@vger.kernel.org, gujx@cn.fujitsu.com, qi.fuli@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HUJSSJVQMG2HNRO5UTMOKPZU4JHRS4LD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 10/30/19 7:48 PM, Goldwyn Rodrigues wrote:
> On 12:13 30/10, Shiyang Ruan wrote:
>> This patchset aims to take care of this issue to make reflink and dedupe
>> work correctly (actually in read/write path, there still has some problems,
>> such as the page->mapping and page->index issue, in mmap path) in XFS under
>> fsdax mode.
> 
> Have you managed to solve the problem of multi-mapped pages? I don't
> think we can include this until we solve that problem. This is the
> problem I faced when I was doing the btrfs dax support.

That problem still exists, didn't be solved in this patchset.  But I am 
also looking into it.  As you know, it's a bit difficult.

Since the iomap for cow is merged in for-next tree, I think it's time to 
update this in order to get some comments.

> 
> Suppose there is an extent shared with multiple files. You map data for
> both files. Which inode should page->mapping->host (precisely
> page->mapping) point to? As Dave pointed out, this needs to be fixed at
> the mm level, and will not only benefit dax with CoW but other
> areas such as overlayfs and possibly containers.

Yes, I will try to figure out a solution.
> 

-- 
Thanks,
Shiyang Ruan.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
