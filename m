Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A8217F13
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 07:28:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80FFD110BA96F;
	Tue,  7 Jul 2020 22:28:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A6BE110B96A4
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 22:28:08 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06852AT6066654;
	Wed, 8 Jul 2020 01:28:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3257fsgsg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 01:28:00 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06852J4H067392;
	Wed, 8 Jul 2020 01:27:59 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3257fsgsfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 01:27:59 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0685OcKV032636;
	Wed, 8 Jul 2020 05:27:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma05fra.de.ibm.com with ESMTP id 3251w8g4tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 05:27:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0685Rtj57340492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2020 05:27:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95F4F11C04C;
	Wed,  8 Jul 2020 05:27:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677E511C04A;
	Wed,  8 Jul 2020 05:27:53 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.29])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2020 05:27:53 +0000 (GMT)
Date: Wed, 8 Jul 2020 08:27:46 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200708052626.GB386073@linux.ibm.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com>
 <20200707180043.GA386073@linux.ibm.com>
 <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_01:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080029
Message-ID-Hash: LC3FEFJTZYYAG5DXQVRBC2EGLNLCPRA3
X-Message-ID-Hash: LC3FEFJTZYYAG5DXQVRBC2EGLNLCPRA3
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LC3FEFJTZYYAG5DXQVRBC2EGLNLCPRA3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 07, 2020 at 03:05:48PM -0700, Dan Williams wrote:
> On Tue, Jul 7, 2020 at 11:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Tue, Jul 07, 2020 at 02:26:08PM +0200, David Hildenbrand wrote:
> > > On 07.07.20 14:13, Mike Rapoport wrote:
> > > > On Tue, Jul 07, 2020 at 01:54:54PM +0200, Michal Hocko wrote:
> > > >> On Tue 07-07-20 13:59:15, Jia He wrote:
> > > >>> This exports memory_add_physaddr_to_nid() for module driver to use.
> > > >>>
> > > >>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> > > >>> NUMA_NO_NID is detected.
> > > >>>
> > > >>> Suggested-by: David Hildenbrand <david@redhat.com>
> > > >>> Signed-off-by: Jia He <justin.he@arm.com>
> > > >>> ---
> > > >>>  arch/arm64/mm/numa.c | 5 +++--
> > > >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >>>
> > > >>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > > >>> index aafcee3e3f7e..7eeb31740248 100644
> > > >>> --- a/arch/arm64/mm/numa.c
> > > >>> +++ b/arch/arm64/mm/numa.c
> > > >>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> > > >>>
> > > >>>  /*
> > > >>>   * We hope that we will be hotplugging memory on nodes we already know about,
> > > >>> - * such that acpi_get_node() succeeds and we never fall back to this...
> > > >>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> > > >>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> > > >>>   */
> > > >>>  int memory_add_physaddr_to_nid(u64 addr)
> > > >>>  {
> > > >>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> > > >>>   return 0;
> > > >>>  }
> > > >>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > > >>
> > > >> Does it make sense to export a noop function? Wouldn't make more sense
> > > >> to simply make it static inline somewhere in a header? I haven't checked
> > > >> whether there is an easy way to do that sanely bu this just hit my eyes.
> > > >
> > > > We'll need to either add a CONFIG_ option or arch specific callback to
> > > > make both non-empty (x86, powerpc, ia64) and empty (arm64, sh)
> > > > implementations coexist ...
> > >
> > > Note: I have a similar dummy (return 0) patch for s390x lying around here.
> >
> > Then we'll call it a tie - 3:3 ;-)
> 
> So I'd be happy to jump on the train of people wanting to export the
> ARM stub for this (and add a new ARM stub for phys_to_target_node()),
> but Will did have a plausibly better idea that I have been meaning to
> circle back to:
> 
> http://lore.kernel.org/r/20200325111039.GA32109@willie-the-truck
> 
> ...i.e. iterate over node data to do the lookup. This would seem to
> work generically for multiple archs unless I am missing something?

I think it would work on arm64, power and, most propbably on s390
(David?), but not on x86. x86 does not have reserved memory in pgdat,
it's never memblock_add()'ed (see e820__memblock_setup()).

I've suggested to add E820_*_RESERVED to memblock.memory a while ago
[1], but apparently there are systems that cannot tolerate OS mappings
of the BIOS reserved areas.

[1] https://lore.kernel.org/lkml/20200522142053.GW1059226@linux.ibm.com/

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
