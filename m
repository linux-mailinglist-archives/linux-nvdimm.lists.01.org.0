Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE64F8ECC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 12:44:36 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 51A3A100DC408;
	Tue, 12 Nov 2019 03:46:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E9152100DC405
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 03:46:19 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBeDxO066762;
	Tue, 12 Nov 2019 06:43:02 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w7t0xn5k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 06:43:02 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xACBedXo070403;
	Tue, 12 Nov 2019 06:43:02 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w7t0xn5hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 06:43:02 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBfCGg005201;
	Tue, 12 Nov 2019 11:42:59 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by ppma02wdc.us.ibm.com with ESMTP id 2w5n35x6wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 11:42:59 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBgwSZ52166954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2019 11:42:58 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE70EAC05B;
	Tue, 12 Nov 2019 11:42:58 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5FFEAC059;
	Tue, 12 Nov 2019 11:42:50 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2019 11:42:50 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 00/16] Memory Hierarchy: Enable target node lookups for reserved memory
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Tue, 12 Nov 2019 17:12:47 +0530
Message-ID: <8736ettj60.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120106
Message-ID-Hash: AT264TWIQJCOKKU75M3S376B2PQTLJFF
X-Message-ID-Hash: AT264TWIQJCOKKU75M3S376B2PQTLJFF
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AT264TWIQJCOKKU75M3S376B2PQTLJFF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> Yes, this patch series looks like a pile of boring libnvdimm cleanups,
> but buried at the end are some small gems that testing with libnvdimm
> uncovered. These gems will prove more valuable over time for Memory
> Hierarchy management as more platforms, via the ACPI HMAT and EFI
> Specific Purpose Memory, publish reserved or "soft-reserved" ranges to
> Linux. Linux system administrators will expect to be able to interact
> with those ranges with a unique numa node number when/if that memory is
> onlined via the dax_kmem driver [1].
>
> One configuration that currently fails to properly convey the target
> node for the resulting memory hotplug operation is persistent memory
> defined by the memmap=nn!ss parameter. For example, today if node1 is a
> memory only node, and all the memory from node1 is specified to
> memmap=nn!ss and subsequently onlined, it will end up being onlined as
> node0 memory. As it stands, memory_add_physaddr_to_nid() can only
> identify online nodes and since node1 in this example has no online cpus
> / memory the target node is initialized node0.
>
> The fix is to preserve rather than discard the numa_meminfo entries that
> are relevant for reserved memory ranges, and to uplevel the node
> distance helper for determining the "local" (closest) node relative to
> an initiator node.
>
> The first 12 patches are cleanups to make sure that all nvdimm devices
> and their children properly export a numa_node attribute. The switch to
> a device-type is less code and less error prone as a result.


Will this still allow leaf driver to have platform specific attribute
exposed via sysfs? Or do we want to still keep them in nvdimm core and
control the visibility via is_visible() callback?

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
