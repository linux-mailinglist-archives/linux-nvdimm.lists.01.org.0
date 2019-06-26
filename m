Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503D56205
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 08:07:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2513C212A36FD;
	Tue, 25 Jun 2019 23:07:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.228.121.143; helo=hqemgate14.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=linux-nvdimm@lists.01.org 
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C2150212A36DD
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 23:07:18 -0700 (PDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d130b940000>; Tue, 25 Jun 2019 23:07:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 25 Jun 2019 23:07:18 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 25 Jun 2019 23:07:18 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Jun
 2019 06:07:14 +0000
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
To: Michal Hocko <mhocko@kernel.org>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de> <20190613194430.GY22062@mellanox.com>
 <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
 <20190613195819.GA22062@mellanox.com>
 <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
 <d2b77ea1-7b27-e37d-c248-267a57441374@nvidia.com>
 <20190619192719.GO9374@mellanox.com>
 <29f43c79-b454-0477-a799-7850e6571bd3@nvidia.com>
 <20190626054554.GA17798@dhcp22.suse.cz>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <f71f16a4-d411-a540-fc71-34d15f4f02d6@nvidia.com>
Date: Tue, 25 Jun 2019 23:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626054554.GA17798@dhcp22.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561529236; bh=lOYN6Xujx0qgVx2R2grB9rnpAuC+tRlCUn6fhuHNVBw=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=MeEaNoyuI3afmGIgQqaUlcM8mWD4HE/GKCjf1kgZqenkygdQ6iZn8Y+wMfzhJF87I
 vYo21C+56S9Bvta+WE93xqp1yxRd+0aF795hDv05MxYNL3r+vvAmMHm4YgF+fZ9DDF
 07zGzHtLnrEybnAKwTuVgiU1Di+G2xgjzSwCSSceljuW82qT60fZLO+EJoH4v/ubsD
 NyaUlJ4MlpZ0Et6J1Gg+pmaLUo/LH/zF/aaAcoZbyC51AIUa7VWPEd94fdesxNrSAi
 U72HjlF1/+oo9PUKkvNA5wckZf7S8p+OANEJ3IUYXElXVcyRJ79Q5H9Zy/HqtbvLbl
 uJqmTWhXrGX7Q==
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
Cc: Ralph Campbell <rcampbell@nvidia.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 6/25/19 10:45 PM, Michal Hocko wrote:
> On Tue 25-06-19 20:15:28, John Hubbard wrote:
>> On 6/19/19 12:27 PM, Jason Gunthorpe wrote:
>>> On Thu, Jun 13, 2019 at 06:23:04PM -0700, John Hubbard wrote:
>>>> On 6/13/19 5:43 PM, Ira Weiny wrote:
>>>>> On Thu, Jun 13, 2019 at 07:58:29PM +0000, Jason Gunthorpe wrote:
>>>>>> On Thu, Jun 13, 2019 at 12:53:02PM -0700, Ralph Campbell wrote:
>>>>>>>
>>>> ...
>>>>> So I think it is ok.  Frankly I was wondering if we should remove the public
>>>>> type altogether but conceptually it seems ok.  But I don't see any users of it
>>>>> so...  should we get rid of it in the code rather than turning the config off?
>>>>>
>>>>> Ira
>>>>
>>>> That seems reasonable. I recall that the hope was for those IBM Power 9
>>>> systems to use _PUBLIC, as they have hardware-based coherent device (GPU)
>>>> memory, and so the memory really is visible to the CPU. And the IBM team
>>>> was thinking of taking advantage of it. But I haven't seen anything on
>>>> that front for a while.
>>>
>>> Does anyone know who those people are and can we encourage them to
>>> send some patches? :)
>>>
>>
>> I asked about this, and it seems that the idea was: DEVICE_PUBLIC was there
>> in order to provide an alternative way to do things (such as migrate memory
>> to and from a device), in case the combination of existing and near-future
>> NUMA APIs was insufficient. This probably came as a follow-up to the early
>> 2017-ish conversations about NUMA, in which the linux-mm recommendation was
>> "try using HMM mechanisms, and if those are inadequate, then maybe we can
>> look at enhancing NUMA so that it has better handling of advanced (GPU-like)
>> devices".
> 
> Yes that was the original idea. It sounds so much better to use a common
> framework rather than awkward special cased cpuless NUMA nodes with
> a weird semantic. User of the neither of the two has shown up so I guess
> that the envisioned HW just didn't materialized. Or has there been a
> completely different approach chosen?

The HW showed up, alright: it's the IBM Power 9, which provides HW-based
memory coherency between its CPUs and GPUs. So on this system, the CPU is
allowed to access GPU memory, which *could* be modeled as DEVICE_PUBLIC.

However, what happened was that the system worked well enough with a combination
of the device driver, plus NUMA APIs, plus heaven knows what sort of /proc tuning
might have also gone on. :) No one saw the need to reach for the DEVICE_PUBLIC
functionality.

> 
>> In the end, however, _PUBLIC was never used, nor does anyone in the local
>> (NVIDIA + IBM) kernel vicinity seem to have plans to use it.  So it really
>> does seem safe to remove, although of course it's good to start with 
>> BROKEN and see if anyone pops up and complains.
> 
> Well, I do not really see much of a difference. Preserving an unused
> code which doesn't have any user in sight just adds a maintenance burden
> whether the code depends on BROKEN or not. We can always revert patches
> which remove the code once a real user shows up.

Sure, I don't see much difference either. Either way seems fine.

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
