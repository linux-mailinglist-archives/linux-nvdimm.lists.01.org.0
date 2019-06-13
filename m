Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A7A44C9E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 21:53:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47B0321296702;
	Thu, 13 Jun 2019 12:53:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=rcampbell@nvidia.com; receiver=linux-nvdimm@lists.01.org 
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 36E8721290DDC
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 12:53:07 -0700 (PDT)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d02a9a20000>; Thu, 13 Jun 2019 12:53:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 13 Jun 2019 12:53:06 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 13 Jun 2019 12:53:06 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 19:53:02 +0000
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
To: Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de> <20190613194430.GY22062@mellanox.com>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
Date: Thu, 13 Jun 2019 12:53:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190613194430.GY22062@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1560455586; bh=Jb4g90Z1ba65oKYjTxGpf+f/32abJWQiXQLuIbWbzvY=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=fX5tey0oBNTieShQOoS4gHfsvizLQIZuWaHc6dzOwFFJidyDqIYU2AUhp266HRFrN
 XrtOPBnaSUAKElzDHFexziLEsf0mgRvYpwoaL4sSYsIU1LcKrpDAHjizgl/yJjcdl3
 p6Pf6shBbCxBVGLYCn7p1Sc7R72zptzPvDHZbEr82hLm46tnMp65GrRnZ3EbGnwLJz
 23lgDPGqY/fbBOf3AXToJKAO/Z8B9A4BRpstqapMwDkQOz+kz4JCB2SNVDQH0ir2MJ
 WzkLVK43aAga/2HoikuGF1iJ+5COBwso/r1BhSmM63r0HyIcQnSmXduf+EERM53rtq
 kwroL2mZCH2Jw==
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On 6/13/19 12:44 PM, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:43:21AM +0200, Christoph Hellwig wrote:
>> The code hasn't been used since it was added to the tree, and doesn't
>> appear to actually be usable.  Mark it as BROKEN until either a user
>> comes along or we finally give up on it.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>   mm/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 0d2ba7e1f43e..406fa45e9ecc 100644
>> +++ b/mm/Kconfig
>> @@ -721,6 +721,7 @@ config DEVICE_PRIVATE
>>   config DEVICE_PUBLIC
>>   	bool "Addressable device memory (like GPU memory)"
>>   	depends on ARCH_HAS_HMM
>> +	depends on BROKEN
>>   	select HMM
>>   	select DEV_PAGEMAP_OPS
> 
> This seems a bit harsh, we do have another kconfig that selects this
> one today:
> 
> config DRM_NOUVEAU_SVM
>          bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
>          depends on ARCH_HAS_HMM
>          depends on DRM_NOUVEAU
>          depends on STAGING
>          select HMM_MIRROR
>          select DEVICE_PRIVATE
>          default n
>          help
>            Say Y here if you want to enable experimental support for
>            Shared Virtual Memory (SVM).
> 
> Maybe it should be depends on STAGING not broken?
> 
> or maybe nouveau_svm doesn't actually need DEVICE_PRIVATE?
> 
> Jason

I think you are confusing DEVICE_PRIVATE for DEVICE_PUBLIC.
DRM_NOUVEAU_SVM does use DEVICE_PRIVATE but not DEVICE_PUBLIC.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
