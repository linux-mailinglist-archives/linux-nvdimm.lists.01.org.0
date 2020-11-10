Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF6F2AC9BD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Nov 2020 01:36:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 16FC2165ADC5D;
	Mon,  9 Nov 2020 16:36:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.143; helo=hqnvemgate24.nvidia.com; envelope-from=jgg@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com [216.228.121.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A1E16165ADC4D
	for <linux-nvdimm@lists.01.org>; Mon,  9 Nov 2020 16:36:24 -0800 (PST)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fa9e08c0000>; Mon, 09 Nov 2020 16:36:30 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov
 2020 00:36:20 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 10 Nov 2020 00:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq2omFVT9IONSuC1q7s6l5V+hD0owSHGKufqWilEgp0RBjadOIA9IZsPiuxpnxN0prVS4BtAfLPcFgOhCHvrcAqSyal32HhdBztPncH8dn4bQjdlfVM53gMMro5YzUpPvjJ+fVksHfdYsumsKOckyFR6q86Av6Bisk8QSr3Rpr45Kuf/H97EQO9opFVRxbLL+sPbUXzHqvxMv+kQULDxuoqJ3vcmVeTSn/stq8alnr84/eTgvJr0CEjmHO4e9gaS1gC9lV9cS7fCjbsIKkgCX/v2X6xxHSZGz1nRfJKctlNjUYX4NUQ5w2b6NVxTe8Z8r7yWtbB3E2trPmtEh/cJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti1Fgx4rJKeuHc3n1lhMdx53onPhwiSmL8/JIQKgYKY=;
 b=YAgkd6W5YvnBcpdBjezZSY3kOtIsWasELNgndcUKVZRoVJFSXtvpGtHoFl//b179/QV4J57yeNsoZ2lpQiEu/edVZ58sVBu4k4uoPsZ/ytk+6gMfhPr8L7cRcEWEvJTHLN8V3N778f1ITh3+xIItUAS7JLZyNxIIA4wJEgcIvMrpZqGAGgncbJdEcZBk7A/at0vj9MK2KeewZuK1h46OuNp4LfQVBwDas8QJRaTJrbPUlkrsM+b6ce6RepiDOq4FjiUI4B2oX2QKUtQn24gsK5No1Tg6T0CtBttdYBvFOCtpAvLuKaSMAM8I1X0zI0iUR1ooZCoASkERy7EPOShg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Tue, 10 Nov
 2020 00:36:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 00:36:19 +0000
Date: Mon, 9 Nov 2020 20:36:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: regression from 5.10.0-rc3: BUG: Bad page state in process
 kworker/41:0 pfn:891066 during fio on devdax
Message-ID: <20201110003616.GA525483@nvidia.com>
References: <1687234809.1086398.1604889506963.JavaMail.zimbra@redhat.com>
 <4ed7ea52-20be-68fe-f920-238ba358395c@redhat.com>
 <20201109141216.GD244516@ziepe.ca>
 <CAPcyv4gJG_-gGwzaenQdnVq13JUWLjEnsTV+e4swuVtpGVpC8g@mail.gmail.com>
 <20201109175442.GE244516@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201109175442.GE244516@ziepe.ca>
X-ClientProxiedBy: BL0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:2d::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:2d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 00:36:18 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from <jgg@nvidia.com>)	id 1kcHdw-002CmV-QG; Mon, 09 Nov 2020 20:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1604968590; bh=Ti1Fgx4rJKeuHc3n1lhMdx53onPhwiSmL8/JIQKgYKY=;
	h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
	 From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType;
	b=MnETtK9f+D7VYRKQoVDeVTux0iuoqv0rVOTbvG/SdklwPf26v5/o9vsY4Vje9HsaI
	 SYdUtrd6u4t5fpEao8a8qiSFU13JZOKuwWEXraOxfrQqDEsUEGHZcgiC0fFsfI5fwv
	 qTBY1kJHgQLP+pv2n0k5emrT41kez/qdTWWQzkmUB19tHpb6Fv5vft6s7FBXjbSFsY
	 4NT0IOsjZyyvXtEev1TkV335+Rpfb+NkKEqXAYlGUVRxbrijCKM6fFkHwiTv/f2wz1
	 efxICyS5QY98MV4wqega8sH9tY4cq8Fg3jOTTZBg+u2JSh00V4veWNOd0kz3HkbXXX
	 eMNRIG589N5aA==
Message-ID-Hash: 74A4AT75D7T6CERMNVEMNG636ZFULA6Z
X-Message-ID-Hash: 74A4AT75D7T6CERMNVEMNG636ZFULA6Z
X-MailFrom: jgg@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Yi Zhang <yi.zhang@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/74A4AT75D7T6CERMNVEMNG636ZFULA6Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

On Mon, Nov 09, 2020 at 01:54:42PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 09, 2020 at 09:26:19AM -0800, Dan Williams wrote:
> > On Mon, Nov 9, 2020 at 6:12 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > Wow, this is surprising
> > >
> > > This has been widely backported already, Dan please check??
> > >
> > > I thought pgprot_decrypted was a NOP on most x86 platforms -
> > > sme_me_mask == 0:
> > >
> > > #define __sme_set(x)            ((x) | sme_me_mask)
> > > #define __sme_clr(x)            ((x) & ~sme_me_mask)
> > >
> > > ??
> > >
> > > Confused how this can be causing DAX issues
> > 
> > Does that correctly preserve the "soft" pte bits? Especially
> > PTE_DEVMAP that DAX uses?
> > 
> > I'll check...
> 
>  extern u64 sme_me_mask;
>  #define __pgprot(x)		((pgprot_t) { (x) } )
>  #define pgprot_val(x)		((x).pgprot)
>  #define __sme_clr(x)            ((x) & ~sme_me_mask)
>  #define pgprot_decrypted(prot)   __pgprot(__sme_clr(pgprot_val(prot)))
> 
>  static inline int io_remap_pfn_range(struct vm_area_struct *vma,
>                                      unsigned long addr, unsigned long pfn,
>                                      unsigned long size, pgprot_t prot)
>  {
>        return remap_pfn_range(vma, addr, pfn, size, pgprot_decrypted(prot));
>  }
> 
> Not seeing how that could change the pgprot in any harmful way?
> 
> Yi, are you using a platform where sme_me_mask != 0 ? 
> 
> That code looks clearly like it would only trigger on AMD SME systems,
> is that what you are using?

Can't be, the system is too old:

 [  398.455914] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/05/2016

I'm at a total loss how this change could even do anything on a
non-AMD system, let alone how this intersects in any way with DEVDAX,
which I could not find being used with io_remap_pfn_range()

How confident are you in the bisection?

Jason
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
