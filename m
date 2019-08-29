Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F4A0FF1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 05:29:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C920D20216B93;
	Wed, 28 Aug 2019 20:31:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=linux-nvdimm@lists.01.org 
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3A59B20215F65
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 20:31:21 -0700 (PDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d6746950001>; Wed, 28 Aug 2019 20:29:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 28 Aug 2019 20:29:23 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 20:29:23 -0700
Received: from [10.2.174.243] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Aug
 2019 03:29:22 +0000
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
To: Ira Weiny <ira.weiny@intel.com>, Dave Chinner <david@fromorbit.com>
References: <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area> <20190823120428.GA12968@ziepe.ca>
 <20190824001124.GI1119@dread.disaster.area>
 <20190824050836.GC1092@iweiny-DESK2.sc.intel.com>
 <20190826055510.GL1119@dread.disaster.area>
 <20190829020230.GA18249@iweiny-DESK2.sc.intel.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <3e5c5053-a74a-509c-660c-a6075ed87f11@nvidia.com>
Date: Wed, 28 Aug 2019 20:27:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829020230.GA18249@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1567049365; bh=U2zxSkDmfFQFUW8ITCuFuqzogPoHzY3eUcatrjlA5a8=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=br5k4UQ1c3ttyAEINc727xSgtnH39dAWjWSCaXGTLwro1CU1YneuoppDXhLMmA4uD
 aDQ3MTA6HOZLsrWjeRsmclmc+9VuPFDc3mjUYq5LVFTaiCoeFJ5fy4G3b324J/gsUa
 1/2Te/7AfanbM290SQcF7x/TWeee+3u45vwvCyED11F/dogTN4V6SByz3yIloOJ3jT
 cLvs8UFo3vWu0RzGtWuxTuxbTth7a/DwXWriVQxLCn7BVTFeq34iQK1UkdryZj/+oB
 pVGut1zha9UABjnIclmX/RBYsT1gxtKg14OYbEVTjMUr+uzTVtNuUOwSxrEb1ZPXtX
 CMDU/9O7s997Q==
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
Cc: Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 8/28/19 7:02 PM, Ira Weiny wrote:
> On Mon, Aug 26, 2019 at 03:55:10PM +1000, Dave Chinner wrote:
>> On Fri, Aug 23, 2019 at 10:08:36PM -0700, Ira Weiny wrote:
>>> On Sat, Aug 24, 2019 at 10:11:24AM +1000, Dave Chinner wrote:
>>>> On Fri, Aug 23, 2019 at 09:04:29AM -0300, Jason Gunthorpe wrote:
...
>>
>> Sure, that part works because the struct file is passed. It doesn't
>> end up with the same fd number in the other process, though.
>>
>> The issue is that layout leases need to notify userspace when they
>> are broken by the kernel, so a lease stores the owner pid/tid in the
>> file->f_owner field via __f_setown(). It also keeps a struct fasync
>> attached to the file_lock that records the fd that the lease was
>> created on.  When a signal needs to be sent to userspace for that
>> lease, we call kill_fasync() and that walks the list of fasync
>> structures on the lease and calls:
>>
>> 	send_sigio(fown, fa->fa_fd, band);
>>
>> And it does for every fasync struct attached to a lease. Yes, a
>> lease can track multiple fds, but it can only track them in a single
>> process context. The moment the struct file is shared with another
>> process, the lease is no longer capable of sending notifications to
>> all the lease holders.
>>
>> Yes, you can change the owning process via F_SETOWNER, but that's
>> still only a single process context, and you can't change the fd in
>> the fasync list. You can add new fd to an existing lease by calling
>> F_SETLEASE on the new fd, but you still only have a single process
>> owner context for signal delivery.
>>
>> As such, leases that require callbacks to userspace are currently
>> only valid within the process context the lease was taken in.
> 
> But for long term pins we are not requiring callbacks.
> 

Hi Ira,

If "require callbacks to userspace" means sending SIGIO, then actually
FOLL_LONGTERM *does* require those callbacks. Because we've been, so
far, equating FOLL_LONGTERM with the vaddr_pin struct and with a lease.

What am I missing here?

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
