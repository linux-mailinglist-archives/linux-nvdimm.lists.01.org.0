Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE501218D74
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 18:47:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2545D110BDB39;
	Wed,  8 Jul 2020 09:47:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 09B4010078AC3
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 09:47:53 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068Gl9PB106211;
	Wed, 8 Jul 2020 12:47:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 325hy4g0mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 12:47:45 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 068GlPXt107652;
	Wed, 8 Jul 2020 12:47:45 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com with ESMTP id 325hy4g0k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 12:47:45 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068GNCu2017283;
	Wed, 8 Jul 2020 16:47:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma06fra.de.ibm.com with ESMTP id 322h1gabfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 16:47:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068GleDI53936356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2020 16:47:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C553AE045;
	Wed,  8 Jul 2020 16:47:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94F43AE053;
	Wed,  8 Jul 2020 16:47:38 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.29])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2020 16:47:38 +0000 (GMT)
Date: Wed, 8 Jul 2020 19:47:36 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200708164736.GD781326@linux.ibm.com>
References: <CAPcyv4jyk_tkDRewTVvRAv0g4LwemEyKYQyuJBXkF4VuYrBdrw@mail.gmail.com>
 <999ea296-4695-1219-6a4d-a027718f61e5@redhat.com>
 <20200708083951.GH386073@linux.ibm.com>
 <cdb0510e-4271-1c97-4305-5fd52da282dc@redhat.com>
 <20200708091520.GE128651@kernel.org>
 <df0e5f64-10bc-4c3c-a515-288a6f501065@redhat.com>
 <20200708094549.GA781326@linux.ibm.com>
 <98166184-3aaf-479e-bfb3-fc737f4ac98d@redhat.com>
 <CAPcyv4guv2wjLDNJ4VN+4ZKiSC-FDvxoRxy5_OvUJ5C1tJsAGA@mail.gmail.com>
 <f80f2466-6e64-b525-dae1-66cb62ceb7f1@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f80f2466-6e64-b525-dae1-66cb62ceb7f1@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_13:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 cotscore=-2147483648 mlxlogscore=999 suspectscore=1
 adultscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080107
Message-ID-Hash: MURQ5E2ZIRZSNUSHTHN5YOQ5JSOKDASM
X-Message-ID-Hash: MURQ5E2ZIRZSNUSHTHN5YOQ5JSOKDASM
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MURQ5E2ZIRZSNUSHTHN5YOQ5JSOKDASM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 08, 2020 at 06:10:19PM +0200, David Hildenbrand wrote:
> On 08.07.20 17:50, Dan Williams wrote:
> > On Wed, Jul 8, 2020 at 3:04 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> > 
> > I'm not quite understanding the concern, or requirement about
> > "updating memblock" in the hotplug path. The routines
> > memory_add_physaddr_to_nid() and phys_to_target_node() are helpers to
> > interrogate platform-firmware numa info through a common abstraction.
> > They place no burden on the memory hotplug code they're just used to
> > see if a hot-added range lies within an existing node span when
> > platform-firmware otherwise fails to communicate a node. x86 can
> > continue to back those helpers with numa_meminfo, arm64 can use a
> > generic memblock implementation and other archs can follow the arm64
> > example if they want better numa answers for drivers.
> > 
> 
> See memblock_add_node()/memblock_remove() in mm/memory_hotplug.c. I
> don't want that code be reactivated for x86/s390x. That's all I am saying.

And these have actual meaning only on arm64 because powerpc does not
rely on memblock for memory hot(un)plug, AFAIU.

Anyway, at the moment we can use memblock on hotplug path only on arm64
and I don't think its the path worth exploring.

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
