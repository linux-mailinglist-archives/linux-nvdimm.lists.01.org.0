Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBB9954D8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 05:11:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1630A2020D32A;
	Mon, 19 Aug 2019 20:12:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.228.121.65; helo=hqemgate16.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=linux-nvdimm@lists.01.org 
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D4E0A2020D313
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 20:12:49 -0700 (PDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d5b64df0000>; Mon, 19 Aug 2019 20:11:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 19 Aug 2019 20:11:27 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 19 Aug 2019 20:11:27 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 03:11:26 +0000
Received: from [10.2.161.11] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 03:11:26 +0000
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
To: Dave Chinner <david@fromorbit.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <ae64491b-85f8-eeca-14e8-2f09caf8abd2@nvidia.com>
 <20190820012021.GQ7777@dread.disaster.area>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <84318b51-bd07-1d9b-d842-e65cac2ff484@nvidia.com>
Date: Mon, 19 Aug 2019 20:09:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820012021.GQ7777@dread.disaster.area>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1566270687; bh=AKYDp6zi8g/3Ey7Fk8otUT5V262BqzkSQ0q+IcrDmeo=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=CZ4ZI+y0zL6VhLHNeKaQ2BvucdquPt4NgzTapmdwmc3GH3ircx3XCkVaxgGV+d4sV
 NV4xzAxkdZ0qipuq6cmTMvEo0GkMUZ0LA3h8jLsrhtdUSK7LJYDcORQUkb27HU5iJS
 D8J/timtnz1ic6DmnMqDlno5UI+SPuaRVL4k6cJ9e1Yy2OisErHDl40bOiFkRHVohj
 dvzXeKjnkRwCke55psIxtF5KXQ3oFpQTgwnRbtrvqucZqN39Wqb3XG4Rtkggo8WdSf
 UF27W8iph40Uw6qp5h0XPXa7CrDBm9DA/1RdEpAz6OMTNS7ZEHj/b9rS0k4Y8oW/rq
 ihGqFKtG8v2lg==
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Theodore
 Ts'o <tytso@mit.edu>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 8/19/19 6:20 PM, Dave Chinner wrote:
> On Mon, Aug 19, 2019 at 05:05:53PM -0700, John Hubbard wrote:
>> On 8/19/19 2:24 AM, Dave Chinner wrote:
>>> On Mon, Aug 19, 2019 at 08:34:12AM +0200, Jan Kara wrote:
>>>> On Sat 17-08-19 12:26:03, Dave Chinner wrote:
>>>>> On Fri, Aug 16, 2019 at 12:05:28PM -0700, Ira Weiny wrote:
>>>>>> On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
>>>>>>> On Wed 14-08-19 11:08:49, Ira Weiny wrote:
>>>>>>>> On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
>> ...
>>
>> Any thoughts about sockets? I'm looking at net/xdp/xdp_umem.c which pins
>> memory with FOLL_LONGTERM, and wondering how to make that work here.
> 
> I'm not sure how this interacts with file mappings? I mean, this
> is just pinning anonymous pages for direct data placement into
> userspace, right?
> 
> Are you asking "what if this pinned memory was a file mapping?",
> or something else?

Yes, mainly that one. Especially since the FOLL_LONGTERM flag is
already there in xdp_umem_pin_pages(), unconditionally. So the
simple rules about struct *vaddr_pin usage (set it to NULL if FOLL_LONGTERM is
not set) are not going to work here.


> 
>> These are close to files, in how they're handled, but just different
>> enough that it's not clear to me how to make work with this system.
> 
> I'm guessing that if they are pinning a file backed mapping, they
> are trying to dma direct to the file (zero copy into page cache?)
> and so they'll need to either play by ODP rules or take layout
> leases, too....
> 

OK. I was just wondering if there was some simple way to dig up a
struct file associated with a socket (I don't think so), but it sounds
like this is an exercise that's potentially different for each subsystem.

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
