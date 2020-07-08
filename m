Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C742182AC
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 10:40:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CAD4A110CED28;
	Wed,  8 Jul 2020 01:40:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E9540110CED27
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 01:40:06 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0688WjMG059558;
	Wed, 8 Jul 2020 04:40:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 325ajv0dx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 04:40:00 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0688Y2d1064240;
	Wed, 8 Jul 2020 04:40:00 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 325ajv0dw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 04:39:59 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0688dvDw010387;
	Wed, 8 Jul 2020 08:39:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma03ams.nl.ibm.com with ESMTP id 322hd7vbkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 08:39:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0688dtYx54001796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2020 08:39:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57CEDA405B;
	Wed,  8 Jul 2020 08:39:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9486A4040;
	Wed,  8 Jul 2020 08:39:53 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.29])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2020 08:39:53 +0000 (GMT)
Date: Wed, 8 Jul 2020 11:39:51 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200708083951.GH386073@linux.ibm.com>
References: <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com>
 <20200707180043.GA386073@linux.ibm.com>
 <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
 <20200708052626.GB386073@linux.ibm.com>
 <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
 <CAPcyv4jyk_tkDRewTVvRAv0g4LwemEyKYQyuJBXkF4VuYrBdrw@mail.gmail.com>
 <999ea296-4695-1219-6a4d-a027718f61e5@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <999ea296-4695-1219-6a4d-a027718f61e5@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_04:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 cotscore=-2147483648 spamscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080061
Message-ID-Hash: W2RNW5TMKYIU5PL2DJYBEFRXJQNMHTUP
X-Message-ID-Hash: W2RNW5TMKYIU5PL2DJYBEFRXJQNMHTUP
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W2RNW5TMKYIU5PL2DJYBEFRXJQNMHTUP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 08, 2020 at 10:26:41AM +0200, David Hildenbrand wrote:
> On 08.07.20 09:50, Dan Williams wrote:
> > On Wed, Jul 8, 2020 at 12:22 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >>>>>>>> On Tue 07-07-20 13:59:15, Jia He wrote:
> >>>>>>>>> This exports memory_add_physaddr_to_nid() for module driver to use.
> >>>>>>>>>
> >>>>>>>>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> >>>>>>>>> NUMA_NO_NID is detected.
> >>>>>>>>>
> >>>>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>>>>>>> Signed-off-by: Jia He <justin.he@arm.com>
> >>>>>>>>> ---
> >>>>>>>>>  arch/arm64/mm/numa.c | 5 +++--
> >>>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >>>>>>>>> index aafcee3e3f7e..7eeb31740248 100644
> >>>>>>>>> --- a/arch/arm64/mm/numa.c
> >>>>>>>>> +++ b/arch/arm64/mm/numa.c
> >>>>>>>>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> >>>>>>>>>
> >>>>>>>>>  /*
> >>>>>>>>>   * We hope that we will be hotplugging memory on nodes we already know about,
> >>>>>>>>> - * such that acpi_get_node() succeeds and we never fall back to this...
> >>>>>>>>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> >>>>>>>>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> >>>>>>>>>   */
> >>>>>>>>>  int memory_add_physaddr_to_nid(u64 addr)
> >>>>>>>>>  {
> >>>>>>>>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >>>>>>>>>   return 0;
> >>>>>>>>>  }
> >>>>>>>>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >>>>>>>>
> >>>>>>>> Does it make sense to export a noop function? Wouldn't make more sense
> >>>>>>>> to simply make it static inline somewhere in a header? I haven't checked
> >>>>>>>> whether there is an easy way to do that sanely bu this just hit my eyes.

> I'd be curious if what we are trying to optimize here is actually worth
> optimizing. IOW, is there a well-known scenario where the dummy value on
> arm64 would be problematic and is worth the effort?

Well, it started with Michal's comment above that EXPORT_SYMBOL_GPL()
for a stub might be an overkill.

I think Jia's suggestion [1] with addition of a comment that explains
why and when the stub will be used, can work for both
memory_add_physaddr_to_nid() and phys_to_target_node().

But on more theoretical/fundmanetal level, I think we lack a generic
abstraction similar to e.g. x86 'struct numa_meminfo' that serves as
translaton of firmware supplied information into data that can be used
by the generic mm without need to reimplement it for each and every
arch.

[1] https://lore.kernel.org/lkml/AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com

> I mean, in all performance relevant setups (ignoring
> hv_balloon/xen-balloon/prove_store(), which also use
> memory_add_physaddr_to_nid()), we should have a proper PXM/node
> specified by the hardware on memory hotadd. The fallback of
> memory_add_physaddr_to_nid() is not relevant in these scenarios.
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
