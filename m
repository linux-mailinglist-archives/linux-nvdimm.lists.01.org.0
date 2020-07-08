Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E3218417
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 11:46:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3199D110E5FD9;
	Wed,  8 Jul 2020 02:46:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E5E69110CED2D
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 02:46:04 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0689Y4Aj181016;
	Wed, 8 Jul 2020 05:45:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32584yej66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 05:45:57 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0689b92K192578;
	Wed, 8 Jul 2020 05:45:57 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32584yej58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 05:45:57 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0689eLGH026392;
	Wed, 8 Jul 2020 09:45:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03fra.de.ibm.com with ESMTP id 322hd7t846-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 09:45:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0689jqQl11338098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2020 09:45:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3C205204E;
	Wed,  8 Jul 2020 09:45:52 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.29])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2F8345204F;
	Wed,  8 Jul 2020 09:45:51 +0000 (GMT)
Date: Wed, 8 Jul 2020 12:45:49 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200708094549.GA781326@linux.ibm.com>
References: <20200707180043.GA386073@linux.ibm.com>
 <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
 <20200708052626.GB386073@linux.ibm.com>
 <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
 <CAPcyv4jyk_tkDRewTVvRAv0g4LwemEyKYQyuJBXkF4VuYrBdrw@mail.gmail.com>
 <999ea296-4695-1219-6a4d-a027718f61e5@redhat.com>
 <20200708083951.GH386073@linux.ibm.com>
 <cdb0510e-4271-1c97-4305-5fd52da282dc@redhat.com>
 <20200708091520.GE128651@kernel.org>
 <df0e5f64-10bc-4c3c-a515-288a6f501065@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df0e5f64-10bc-4c3c-a515-288a6f501065@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_07:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 suspectscore=1 phishscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080069
Message-ID-Hash: IWG7RKQFJQIO45LR2C427KUJGY5RMEAP
X-Message-ID-Hash: IWG7RKQFJQIO45LR2C427KUJGY5RMEAP
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IWG7RKQFJQIO45LR2C427KUJGY5RMEAP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 08, 2020 at 11:25:36AM +0200, David Hildenbrand wrote:
> On 08.07.20 11:15, Mike Rapoport wrote:
> >>>>>>
> >>> But on more theoretical/fundmanetal level, I think we lack a generic
> >>> abstraction similar to e.g. x86 'struct numa_meminfo' that serves as
> >>> translaton of firmware supplied information into data that can be used
> >>> by the generic mm without need to reimplement it for each and every
> >>> arch.
> >>
> >> Right. As I expressed, I am not a friend of using memblock for that, and
> >> the pgdat node span is tricky.
> >>
> >> Maybe abstracting that x86 concept is possible in some way (and we could
> >> restrict the information to boot-time properties, so we don't have to
> >> mess with memory hot(un)plug - just as done for numa_meminfo AFAIKS).
> > 
> > I agree with pgdat part and disagree about memblock. It already has
> > non-init physmap, why won't we add memblock.memory to the mix? ;-)
> 
> Can we generalize and tweak physmap to contain node info? That's all we
> need, no? (the special mem= parameter handling should not matter for our
> use case, where "physmap" and "memory" would differ)

TBH, I have only random vague thoughts at the moment. This might be an
option. But then we need to enable physmap on !s390, right?
 
> > Now, seriously, memblock already has all the necessary information about
> > the coldplug memory for several architectures. x86 being an exception
> > because for some reason the reserved memory is not considered memory
> > there. The infrastructure for quiering and iterating memory regions is
> > already there. We just need to leave out the irrelevant parts, like
> > memblock.reserved and allocation funcions.
> 
> I *really* don't want to mess with memblocks on memory hot(un)plug on
> x86 and s390x (+other architectures in the future). I also thought about
> stopping to create memblocks for hotplugged memory on arm64, by tweaking
> pfn_valid() to query memblocks only for early sections.
>
> If "physmem" is not an option, can we at least introduce something like
> ARCH_UPDTAE_MEMBLOCK_ON_HOTPLUG to avoid doing that on x86 and s390x for
> now (and later maybe for others)?

I have to do more memory hotplug howework to answer that ;-)

My general point is that we don't have to reinvent the wheel to have
coldplug memory representation, it's already there. We just need a way
to use it properly.

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
