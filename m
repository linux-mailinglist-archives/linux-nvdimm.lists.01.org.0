Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B9169D00
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 05:34:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 635C010FC3408;
	Sun, 23 Feb 2020 20:35:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9738A10FC3190
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 20:35:12 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01O4TGiq018785
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 23:34:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1b6s54v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 23:34:19 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Mon, 24 Feb 2020 04:34:17 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 24 Feb 2020 04:34:10 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01O4Y9sb40239424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2020 04:34:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2D99AE045;
	Mon, 24 Feb 2020 04:34:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32F1CAE053;
	Mon, 24 Feb 2020 04:34:09 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2020 04:34:09 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 88A0EA00E5;
	Mon, 24 Feb 2020 15:34:04 +1100 (AEDT)
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory
 devices
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 24 Feb 2020 15:34:07 +1100
In-Reply-To: <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022404-0020-0000-0000-000003ACF5B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022404-0021-0000-0000-00002205050E
Message-Id: <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-23_07:2020-02-21,2020-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240037
Message-ID-Hash: YUKY3CQZT7IBPAG7X6UYZ26CDBQRSRCP
X-Message-ID-Hash: YUKY3CQZT7IBPAG7X6UYZ26CDBQRSRCP
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
 , Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YUKY3CQZT7IBPAG7X6UYZ26CDBQRSRCP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2020-02-21 at 08:21 -0800, Dan Williams wrote:
> On Thu, Feb 20, 2020 at 7:28 PM Alastair D'Silva <
> alastair@au1.ibm.com> wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This series adds support for OpenCAPI Persistent Memory devices,
> > exposing
> > them as nvdimms so that we can make use of the existing
> > infrastructure.
> 
> A single sentence to introduce:
> 
> 24 files changed, 3029 insertions(+), 97 deletions(-)
> 
> ...is inadequate. What are OpenCAPI Persistent Memory devices? How do
> they compare, in terms relevant to libnvdimm, to other persistent
> memory devices? What challenges do they pose to the existing
> enabling?
> What is the overall approach taken with this 27 patch break down?
> What
> are the changes since v2, v1? If you incorporated someone's review
> feedback note it in the cover letter changelog, if you didn't
> incorporate someone's feedback note that too with an explanation.
> 
> In short, provide a bridge document for someone familiar with the
> upstream infrastructure, but not necessarily steeped in powernv /
> OpenCAPI platform details, to get started with this code.
> 
> For now, no need to resend the whole series, just reply to this
> message with a fleshed out cover letter and then incorporate it going
> forward for v4+.


Apologies, I was maintaining a changelog, and forgot to include it.
I'll flesh out the cover letter too:

This series adds support for OpenCAPI Persistent Memory devices on bare
metal (arch/powernv), exposing them as nvdimms so that we can make use
of the existing infrastructure. There already exists a driver for the
same devices abstracted through PowerVM (arch/pseries):
arch/powerpc/platforms/pseries/papr_scm.c

These devices are connected via OpenCAPI, and present as LPC (lowest
coherence point) memory to the system, practically, that means that
memory on these cards could be treated as conventional, cache-coherent
memory.

Since the devices are connected via OpenCAPI, they are not enumerated
via ACPI. Instead, OpenCAPI links present as pseudo-PCI bridges, with
devices below them.

This series introduces a driver that exposes the memory on these cards
as nvdimms, with each card getting it's own bus. This is somewhat
complicated by the fact that the cards do not have out of band
persistent storage for metadata, so 1 SECTION_SIZE's (see SPARSEMEM)
worth of storage is carved out of the top of the card storage to
implement the ndctl_config_* calls.

The driver is not responsible for configuring the NPU (NVLink
Processing Unit) BARs to map the LPC memory from the card into the
system's physical address space, instead, it requests this to be done
via OPAL calls (typically implemented by Skiboot).

The series is structured as follows:
 - Required infrastructure changes & cleanup
 - A minimal driver implementation
 - Implementing additional features within the driver

V3:
  - Rebase against next/next-20200220
  - Move driver to arch/powerpc/platforms/powernv, we now expect this
    driver to go upstream via the powerpc tree
  - "nvdimm/ocxl: Implement the Read Error Log command"
	- Fix bad header path
  - "nvdimm/ocxl: Read the capability registers & wait for device
ready"
	- Fix overlapping masks between readiness_timeout &
memory_available_timeout
  - "nvdimm: Add driver for OpenCAPI Storage Class Memory"
	- Address minor review comments from Jonathan Cameron
	- Remove attributes
	- Default to module if building LIBNVDIMM
	- Propogate errors up from called functions in probe()
  - "nvdimm/ocxl: Expose SMART data via ndctl"
	- Pack attributes in struct
	- Support different size SMART buffers for compatibility with
newer
	  ndctls that may want more SMART attribs than we provide
	- Rework to to use ND_CMD_CALL instead of ND_CMD_SMART
  - drop "ocxl: Free detached contexts in ocxl_context_detach_all()"
  - "powerpc: Map & release OpenCAPI LPC memory"
	- Remove 'extern'
	- Only available with CONFIG_MEMORY_HOTPLUG_SPARSE
  - "ocxl: Tally up the LPC memory on a link & allow it to be mapped"
	- Address minor review comments from Jonathan Cameron
  - "ocxl: Add functions to map/unmap LPC memory"
	- Split detected memory message into a separate patch
	- Address minor review comments from Jonathan Cameron
	- Add a comment explaining why unmap_lpc_mem is in
deconfigure_afu
  - "nvdimm/ocxl: Add support for Admin commands"
	- use sizeof(u64) rather than 0x08 when iterating u64s
  - "nvdimm/ocxl: Implement the heartbeat command"
	- Fix typo in blurb
  - Address kernel doc issues
  - Ensure all uapi headers use C89 compatible comments
  - Drop patches for firmware update & overwrite, these will be
    submitted later once patches are available for ndctl
  - Rename SCM to OpenCAPI Persistent Memory

V2:
  - "powerpc: Map & release OpenCAPI LPC memory"
      - Fix #if -> #ifdef
      - use pci_dev_id to get the bdfn
      - use __be64 to hold be data
      - indent check_hotplug_memory_addressable correctly 
      - Remove export of check_hotplug_memory_addressable
  - "ocxl: Conditionally bind SCM devices to the generic OCXL driver"
      - Improve patch description and remove redundant default
  - "nvdimm: Add driver for OpenCAPI Storage Class Memory"
      - Mark a few funcs as static as identified by the 0day bot
      - Add OCXL dependancies to OCXL_SCM
      - Use memcpy_mcsafe in scm_ndctl_config_read
      - Rename scm_foo_offset_0x00 to scm_foo_header_parse & add docs
      - Name DIMM attribs "ocxl" rather than "scm"
      - Split out into base + many feature patches
  - "powerpc: Enable OpenCAPI Storage Class Memory driver on bare
metal"
      - Build DEV_DAX & friends as modules
  - "ocxl: Conditionally bind SCM devices to the generic OCXL driver"
      - Patch dropped (easy enough to maintain this out of tree for
development)
  - "ocxl: Tally up the LPC memory on a link & allow it to be mapped"
      - Add a warning if an unmatched lpc_release is called
  - "ocxl: Add functions to map/unmap LPC memory"
      - Use EXPORT_SYMBOL_GPL

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
