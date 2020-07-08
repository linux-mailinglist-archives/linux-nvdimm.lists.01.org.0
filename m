Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA6218180
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 09:43:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6ADA9110CC32E;
	Wed,  8 Jul 2020 00:43:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4625110CC32D
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 00:43:41 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0687ZBU7084933;
	Wed, 8 Jul 2020 03:43:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3259jh0qs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 03:43:35 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0687ZUZb085972;
	Wed, 8 Jul 2020 03:43:34 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3259jh0qrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 03:43:34 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0687akGU011322;
	Wed, 8 Jul 2020 07:43:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04ams.nl.ibm.com with ESMTP id 322hd7v98w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 07:43:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0687hT918651068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2020 07:43:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 310C911C052;
	Wed,  8 Jul 2020 07:43:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FFFC11C04C;
	Wed,  8 Jul 2020 07:43:27 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.29])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2020 07:43:27 +0000 (GMT)
Date: Wed, 8 Jul 2020 10:43:25 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200708074325.GG386073@linux.ibm.com>
References: <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ivyJsyzcbkBWcqBYZMx3VdJF7+VPCNs177DU2rYqtz_A@mail.gmail.com>
 <20200708062217.GE386073@linux.ibm.com>
 <c4ee0a94-c980-80ca-c43d-15729e1a3663@redhat.com>
 <CAPcyv4inaZgmv=S36_DofA9prKhWg4KBNPkTvzSALO6Vtb9ddw@mail.gmail.com>
 <6aae78fa-b505-0f76-087b-d8b2146c62f1@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6aae78fa-b505-0f76-087b-d8b2146c62f1@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_04:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 spamscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 bulkscore=0 cotscore=-2147483648 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080049
Message-ID-Hash: UPO4TXIDCUP446AZKOU2T4J6GGXCXTKX
X-Message-ID-Hash: UPO4TXIDCUP446AZKOU2T4J6GGXCXTKX
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Justin He <Justin.He@arm.com>, Michal Hocko <mhocko@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UPO4TXIDCUP446AZKOU2T4J6GGXCXTKX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 08, 2020 at 09:16:01AM +0200, David Hildenbrand wrote:
> On 08.07.20 09:04, Dan Williams wrote:
> > On Tue, Jul 7, 2020 at 11:59 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 08.07.20 08:22, Mike Rapoport wrote:
> >>> On Tue, Jul 07, 2020 at 09:27:43PM -0700, Dan Williams wrote:
> >>>> On Tue, Jul 7, 2020 at 9:08 PM Justin He <Justin.He@arm.com> wrote:
> >>>> [..]
> >>>>>> Especially for architectures that use memblock info for numa info
> >>>>>> (which seems to be everyone except x86) why not implement a generic
> >>>>>> memory_add_physaddr_to_nid() that does:
> >>>>>>
> >>>>>> int memory_add_physaddr_to_nid(u64 addr)
> >>>>>> {
> >>>>>>         unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
> >>>>>>         int nid;
> >>>>>>
> >>>>>>         for_each_online_node(nid) {
> >>>>>>                 get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> >>>>>>                 if (pfn >= start_pfn && pfn <= end_pfn)
> >>>>>>                         return nid;
> >>>>>>         }
> >>>>>>         return NUMA_NO_NODE;
> >>>>>> }
> >>>>>
> >>>>> Thanks for your suggestion,
> >>>>> Could I wrap the codes and let memory_add_physaddr_to_nid simply invoke
> >>>>> phys_to_target_node()?
> >>>>
> >>>> I think it needs to be the reverse. phys_to_target_node() should call
> >>>> memory_add_physaddr_to_nid() by default, but fall back to searching
> >>>> reserved memory address ranges in memblock. See phys_to_target_node()
> >>>> in arch/x86/mm/numa.c. That one uses numa_meminfo instead of memblock,
> >>>> but the principle is the same i.e. that a target node may not be
> >>>> represented in memblock.memory, but memblock.reserved. I'm working on
> >>>> a patch to provide a function similar to get_pfn_range_for_nid() that
> >>>> operates on reserved memory.
> >>>
> >>> Do we really need yet another memblock iterator?
> >>> I think only x86 has memory that is not in memblock.memory but only in
> >>> memblock.reserved.
> >>
> >> Reading about abusing the memblock allcoator once again in memory
> >> hotplug paths makes me shiver.
> > 
> > Technical reasoning please?
> 
> ARCH_KEEP_MEMBLOCK is (AFAIK) only a hack for arm64 to implement
> pfn_valid(), because they zap out individual pages corresponding to
> memory holes of full sections.
> 
> I am not a friend of adding more post-init code to rely on memblock
> data. It just makes it harder to eventually get rid of ARCH_KEEP_MEMBLOCK.

The most heavy user of memblock in post-init code is powerpc. It won't
be easy to get rid of it there.

> > arm64 numa information is established from memblock data. It seems
> > counterproductive to ignore that fact if we're already touching
> > memory_add_physaddr_to_nid() and have a use case for a driver to call
> > it.
> 
> ... and we are trying to handle the "only a single dummy node" case
> (patch #2), or what am I missing? What is there to optimize currently?
> 
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
