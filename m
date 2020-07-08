Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3995D218156
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 09:38:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1BD2110CC32C;
	Wed,  8 Jul 2020 00:38:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DEA39110CC32B
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 00:38:42 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0687YbOu022214;
	Wed, 8 Jul 2020 03:38:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3258t4sts7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 03:38:35 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0687Z19g024112;
	Wed, 8 Jul 2020 03:38:34 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3258t4strc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 03:38:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0687ajNX019581;
	Wed, 8 Jul 2020 07:38:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma06ams.nl.ibm.com with ESMTP id 322h1h46rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 07:38:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0687cTbS52560072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2020 07:38:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C271AE045;
	Wed,  8 Jul 2020 07:38:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB904AE055;
	Wed,  8 Jul 2020 07:38:27 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.29])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2020 07:38:27 +0000 (GMT)
Date: Wed, 8 Jul 2020 10:38:26 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200708073826.GF386073@linux.ibm.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com>
 <20200707180043.GA386073@linux.ibm.com>
 <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
 <20200708052626.GB386073@linux.ibm.com>
 <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_04:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 cotscore=-2147483648 mlxscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=2 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080053
Message-ID-Hash: FTU7HG66N6BJBGNDFKQAVZCMF5WRLLQU
X-Message-ID-Hash: FTU7HG66N6BJBGNDFKQAVZCMF5WRLLQU
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FTU7HG66N6BJBGNDFKQAVZCMF5WRLLQU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 08, 2020 at 09:21:25AM +0200, David Hildenbrand wrote:
> On 08.07.20 07:27, Mike Rapoport wrote:
> > On Tue, Jul 07, 2020 at 03:05:48PM -0700, Dan Williams wrote:
> >> On Tue, Jul 7, 2020 at 11:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>>
> >>> On Tue, Jul 07, 2020 at 02:26:08PM +0200, David Hildenbrand wrote:
> >>>> On 07.07.20 14:13, Mike Rapoport wrote:
> >>>>> On Tue, Jul 07, 2020 at 01:54:54PM +0200, Michal Hocko wrote:
> >>>>>> On Tue 07-07-20 13:59:15, Jia He wrote:
> >>>>>>> This exports memory_add_physaddr_to_nid() for module driver to use.
> >>>>>>>
> >>>>>>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> >>>>>>> NUMA_NO_NID is detected.
> >>>>>>>
> >>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>>>>> Signed-off-by: Jia He <justin.he@arm.com>
> >>>>>>> ---
> >>>>>>>  arch/arm64/mm/numa.c | 5 +++--
> >>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >>>>>>> index aafcee3e3f7e..7eeb31740248 100644
> >>>>>>> --- a/arch/arm64/mm/numa.c
> >>>>>>> +++ b/arch/arm64/mm/numa.c
> >>>>>>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> >>>>>>>
> >>>>>>>  /*
> >>>>>>>   * We hope that we will be hotplugging memory on nodes we already know about,
> >>>>>>> - * such that acpi_get_node() succeeds and we never fall back to this...
> >>>>>>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> >>>>>>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> >>>>>>>   */
> >>>>>>>  int memory_add_physaddr_to_nid(u64 addr)
> >>>>>>>  {
> >>>>>>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >>>>>>>   return 0;
> >>>>>>>  }
> >>>>>>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >>>>>>
> >>>>>> Does it make sense to export a noop function? Wouldn't make more sense
> >>>>>> to simply make it static inline somewhere in a header? I haven't checked
> >>>>>> whether there is an easy way to do that sanely bu this just hit my eyes.
> >>>>>
> >>>>> We'll need to either add a CONFIG_ option or arch specific callback to
> >>>>> make both non-empty (x86, powerpc, ia64) and empty (arm64, sh)
> >>>>> implementations coexist ...
> >>>>
> >>>> Note: I have a similar dummy (return 0) patch for s390x lying around here.
> >>>
> >>> Then we'll call it a tie - 3:3 ;-)
> >>
> >> So I'd be happy to jump on the train of people wanting to export the
> >> ARM stub for this (and add a new ARM stub for phys_to_target_node()),
> >> but Will did have a plausibly better idea that I have been meaning to
> >> circle back to:
> >>
> >> http://lore.kernel.org/r/20200325111039.GA32109@willie-the-truck
> >>
> >> ...i.e. iterate over node data to do the lookup. This would seem to
> >> work generically for multiple archs unless I am missing something?
> 
> IIRC, only memory assigned to/onlined to a ZONE is represented in the
> pgdat node span. E.g., not offline memory blocks.
> 
> Esp., when hotplugging + onlining consecutive memory, there won't really
> be any intersections in most cases if I am not wrong. It would not be
> "intersection" but rather "closest fit".
> 
> With overlapping nodes it's even more unclear. Which one to pick?
> 
> > 
> > I think it would work on arm64, power and, most propbably on s390
> 
> With only a single dummy node I guess it should work (searching when
> there is only a single node does not make too much sense).
> 
> > (David?), but not on x86. x86 does not have reserved memory in pgdat,
> > it's never memblock_add()'ed (see e820__memblock_setup()).
> 
> Can you enlighten me why that is relevant for the memory hotplug path?
> (or is it just a general comment to make the function as accurate as
> possible for all addresses?)

phys_to_target_node() on x86 falls back to numa_reserved_meminfo which
holds memory that is never listed in a node.

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
