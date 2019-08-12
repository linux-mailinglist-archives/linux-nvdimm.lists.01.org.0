Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1558A930
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 23:20:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C56821311BFA;
	Mon, 12 Aug 2019 14:22:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=linux-nvdimm@lists.01.org 
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AD6CB2130D7EF
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 14:22:38 -0700 (PDT)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d51d81e0001>; Mon, 12 Aug 2019 14:20:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 12 Aug 2019 14:20:19 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 14:20:19 -0700
Received: from MacBook-Pro-10.local (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 21:20:16 +0000
Subject: Re: [RFC PATCH v2 15/19] mm/gup: Introduce vaddr_pin_pages()
To: Ira Weiny <ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-16-ira.weiny@intel.com>
 <6ed26a08-4371-9dc1-09eb-7b8a4689d93b@nvidia.com>
 <20190812210013.GC20634@iweiny-DESK2.sc.intel.com>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b4e15390-701d-c6e9-564c-04e6a3effd50@nvidia.com>
Date: Mon, 12 Aug 2019 14:20:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812210013.GC20634@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1565644830; bh=JroT/x6S1SiN0zFyCuj22OCuZxP8/vKF5Bd4ngANWFg=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=i3VfG8jwOmXxQPogIwZ3sMCwfa3CGn1sVpvN5L89ZpC8daRGO/R9vtPcQ47P9mJKh
 RafMQn1lyj28wP20RL4bwfklVqGKlcfPAph9NXoIwgiQdHwPgcKbnROYw10gmdDVRB
 1aS4zaWboi6HStNT7Yrmu295QTNK0j6K5HIrCLRwR8jCgH/8n6x020QR0zeCSySUVY
 VAXLG041hhDzAzbF3ygoB+7XO9fFnjFaejfE1ChOqzhEU5/hswkEAbHCgQ7dScaDdG
 w+6XfT+PtAoSQVM3gP/Vv3ydQrcAmDn+XK4KuZZlDuKzgjlPJSCpn8JEDKzDbcX5Uy
 UcyfVCRj6Jjvg==
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
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 8/12/19 2:00 PM, Ira Weiny wrote:
> On Fri, Aug 09, 2019 at 05:09:54PM -0700, John Hubbard wrote:
>> On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
>>> From: Ira Weiny <ira.weiny@intel.com>
...
> 
> At one point I wanted to (and had in my tree) a new flag but I went away from
> it.  Prior to the discussion on mlock last week I did not think we needed it.
> But I'm ok to add it back in.
> 
> I was not ignoring the idea for this RFC I just wanted to get this out there
> for people to see.  I see that you threw out a couple of patches which add this
> flag in.
> 
> FWIW, I think it would be good to differentiate between an indefinite pinned
> page vs a referenced "gotten" page.
> 
> What you and I have been working on is the former.  So it would be easy to
> change your refcounting patches to simply key off of FOLL_PIN.
> 
> Would you like me to add in your FOLL_PIN patches to this series?

Sure, that would be perfect. They don't make any sense on their own, and
it's all part of the same design idea.

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
