Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E365A96DA
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 01:12:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 206C521962301;
	Wed,  4 Sep 2019 16:13:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.228.121.143; helo=hqemgate14.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=linux-nvdimm@lists.01.org 
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2762220260CEC
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 16:13:39 -0700 (PDT)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d7044e40000>; Wed, 04 Sep 2019 16:12:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 04 Sep 2019 16:12:35 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 04 Sep 2019 16:12:35 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 23:12:35 +0000
Subject: Re: [RFC PATCH v2 02/19] fs/locks: Add Exclusive flag to user Layout
 lease
To: <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-3-ira.weiny@intel.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <69a7c037-6b4b-dbe3-2b42-77f85043b9eb@nvidia.com>
Date: Wed, 4 Sep 2019 16:12:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809225833.6657-3-ira.weiny@intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1567638756; bh=KcHEqM2TNQedobjZznlViJ4AvUuHmWBw0j98IvGFhfc=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=G4fn03uVMA7J4UC1m9Yj7DhfsqKE5JCNHVM+oBqTe0AR3ZAlGEFmH7YKmkjPCmtCQ
 LUvXJdUANpLjlNJVqXY9TBqjeHx+L53SCBVVR7cf/kJBTDzGJICMvneFxnJ/bznKdv
 dNrJ4yQD+F1DCobVh03UMVVgaQfrILzPPrM7GeO2NaLVNZG5LHBQIJvvbOmoaMH7bs
 msCDq0E+I3UeIhdWC/toHOT1SlxdWDyKPOg3HjVgFJReZrxpb8PrvSxEcypog9tmYA
 zj992eW84rG8B8gGL5qOlDh0yQONipgKi9UW/dLLh2vAF7f5ffKJVuuRAS6ttv/Rev
 x8kDOD2mdY4mQ==
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
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-fsdevel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add an exclusive lease flag which indicates that the layout mechanism
> can not be broken.

After studying the rest of these discussions extensively, I think in all
cases FL_EXCLUSIVE is better named "unbreakable", rather than exclusive.

If you read your sentence above, it basically reinforces that idea: "add an
exclusive flag to mean it is unbreakable" is a bit of a disconnect. It 
would be better to say,

Add an "unbreakable" lease flag which indicates that the layout lease
cannot be broken.

Furthermore, while this may or may not be a way forward on the "we cannot
have more than one process take a layout lease on a file/range", it at
least stops making it impossible. In other words, no one is going to
write a patch that allows sharing an exclusive layout lease--but someone
might well update some of these patches here to make it possible to
have multiple processes take unbreakable leases on the same file/range.

I haven't worked through everything there yet, but again:

* FL_UNBREAKABLE is the name you're looking for here, and

* I think we want to allow multiple processes to take FL_UNBREAKABLE
leases on the same file/range, so that we can make RDMA setups
reasonable. By "reasonable" I mean, "no need to have a lead process
that owns all the leases".



thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
