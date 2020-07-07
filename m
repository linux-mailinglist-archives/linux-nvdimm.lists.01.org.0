Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FCA2175C2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 20:01:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 527071108EF24;
	Tue,  7 Jul 2020 11:01:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA4941108E90D
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 11:01:00 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067HWPj9190732;
	Tue, 7 Jul 2020 14:00:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 324ptpxudc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2020 14:00:53 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 067HvTEq104818;
	Tue, 7 Jul 2020 14:00:53 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com with ESMTP id 324ptpxubh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2020 14:00:52 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067HpdAD011540;
	Tue, 7 Jul 2020 18:00:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma06fra.de.ibm.com with ESMTP id 322h1g9tcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2020 18:00:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067I0l8434406650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2020 18:00:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3714F4C050;
	Tue,  7 Jul 2020 18:00:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC2284C070;
	Tue,  7 Jul 2020 18:00:45 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.169])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Jul 2020 18:00:45 +0000 (GMT)
Date: Tue, 7 Jul 2020 21:00:43 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200707180043.GA386073@linux.ibm.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_09:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=1 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070119
Message-ID-Hash: Y4BHIKSHDGTPNQBK45ZBL3RPVI7PHC2Q
X-Message-ID-Hash: Y4BHIKSHDGTPNQBK45ZBL3RPVI7PHC2Q
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y4BHIKSHDGTPNQBK45ZBL3RPVI7PHC2Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 07, 2020 at 02:26:08PM +0200, David Hildenbrand wrote:
> On 07.07.20 14:13, Mike Rapoport wrote:
> > On Tue, Jul 07, 2020 at 01:54:54PM +0200, Michal Hocko wrote:
> >> On Tue 07-07-20 13:59:15, Jia He wrote:
> >>> This exports memory_add_physaddr_to_nid() for module driver to use.
> >>>
> >>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> >>> NUMA_NO_NID is detected.
> >>>
> >>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>> Signed-off-by: Jia He <justin.he@arm.com>
> >>> ---
> >>>  arch/arm64/mm/numa.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >>> index aafcee3e3f7e..7eeb31740248 100644
> >>> --- a/arch/arm64/mm/numa.c
> >>> +++ b/arch/arm64/mm/numa.c
> >>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> >>>  
> >>>  /*
> >>>   * We hope that we will be hotplugging memory on nodes we already know about,
> >>> - * such that acpi_get_node() succeeds and we never fall back to this...
> >>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> >>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> >>>   */
> >>>  int memory_add_physaddr_to_nid(u64 addr)
> >>>  {
> >>> -	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >>>  	return 0;
> >>>  }
> >>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >>
> >> Does it make sense to export a noop function? Wouldn't make more sense
> >> to simply make it static inline somewhere in a header? I haven't checked
> >> whether there is an easy way to do that sanely bu this just hit my eyes.
> > 
> > We'll need to either add a CONFIG_ option or arch specific callback to
> > make both non-empty (x86, powerpc, ia64) and empty (arm64, sh)
> > implementations coexist ...
> 
> Note: I have a similar dummy (return 0) patch for s390x lying around here.

Then we'll call it a tie - 3:3 ;-)
 
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
