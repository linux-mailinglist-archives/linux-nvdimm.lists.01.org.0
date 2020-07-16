Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D8222BCE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 21:22:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 725F311571BF8;
	Thu, 16 Jul 2020 12:22:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9AE4211571BF6
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 12:22:33 -0700 (PDT)
IronPort-SDR: 9FLoCY7Sjt/oIEg2oqmYw4+SBE7rILvFHg5dKUDcfx1IJI0Zaer9Aq+qHSYhqMusU5KAceFWCj
 zkyYxW1VpvtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="211019345"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800";
   d="scan'208";a="211019345"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 12:22:31 -0700
IronPort-SDR: sgWxlqjo1o6M17PeT2mAk1npmR0Kl1zMweC45j6CMnKH9JT+PJF2Rv8sb2dKMXOqY+CIftrs+L
 90QbTPTpNyHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800";
   d="scan'208";a="269337770"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jul 2020 12:22:31 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.122]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.226]) with mapi id 14.03.0439.000;
 Thu, 16 Jul 2020 12:22:30 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Kaneda, Erik"
	<erik.kaneda@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
Thread-Topic: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
Thread-Index: AQHWTjNF6NPdlNtf4Ea9cCuLXaianakLJdUA
Date: Thu, 16 Jul 2020 19:22:30 +0000
Message-ID: <1738949fd49e9804722bf82d790e3022fc714677.camel@intel.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <2788992.3K7huLjdjL@kreacher> <1666722.UopIai5n7p@kreacher>
	 <1794490.F2OrUDcHQn@kreacher>
In-Reply-To: <1794490.F2OrUDcHQn@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <1158D79CC86D694ABE0899C328498051@intel.com>
MIME-Version: 1.0
Message-ID-Hash: XRGQIBKUAEMTQC57NMEHQYNM7D5QOFNO
X-Message-ID-Hash: XRGQIBKUAEMTQC57NMEHQYNM7D5QOFNO
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"myron.stowe@redhat.com" <myron.stowe@redhat.com>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"Moore,"@ml01.01.org, Robert@ml01.01.org,
	" <robert.moore@intel.com>, "@ml01.01.org,
	linux-acpi@vger.kernel.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XRGQIBKUAEMTQC57NMEHQYNM7D5QOFNO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-06-29 at 18:33 +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The ACPICA's strategy with respect to the handling of memory mappings
> associated with memory operation regions is to avoid mapping the
> entire region at once which may be problematic at least in principle
> (for example, it may lead to conflicts with overlapping mappings
> having different attributes created by drivers).  It may also be
> wasteful, because memory opregions on some systems take up vast
> chunks of address space while the fields in those regions actually
> accessed by AML are sparsely distributed.
> 
> For this reason, a one-page "window" is mapped for a given opregion
> on the first memory access through it and if that "window" does not
> cover an address range accessed through that opregion subsequently,
> it is unmapped and a new "window" is mapped to replace it.  Next,
> if the new "window" is not sufficient to acess memory through the
> opregion in question in the future, it will be replaced with yet
> another "window" and so on.  That may lead to a suboptimal sequence
> of memory mapping and unmapping operations, for example if two fields
> in one opregion separated from each other by a sufficiently wide
> chunk of unused address space are accessed in an alternating pattern.
> 
> The situation may still be suboptimal if the deferred unmapping
> introduced previously is supported by the OS layer.  For instance,
> the alternating memory access pattern mentioned above may produce
> a relatively long list of mappings to release with substantial
> duplication among the entries in it, which could be avoided if
> acpi_ex_system_memory_space_handler() did not release the mapping
> used by it previously as soon as the current access was not covered
> by it.
> 
> In order to improve that, modify acpi_ex_system_memory_space_handler()
> to preserve all of the memory mappings created by it until the memory
> regions associated with them go away.
> 
> Accordingly, update acpi_ev_system_memory_region_setup() to unmap all
> memory associated with memory opregions that go away.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/evrgnini.c | 14 ++++----
>  drivers/acpi/acpica/exregion.c | 65 ++++++++++++++++++++++++----------
>  include/acpi/actypes.h         | 12 +++++--
>  3 files changed, 64 insertions(+), 27 deletions(-)
> 

Hi Rafael,

Picking up from Dan while he's out - I had these patches tested by the
original reporter, and they work fine. I see you had them staged in the
acpica-osl branch. Is that slated to go in during the 5.9 merge window?

You can add:
Tested-by: Xiang Li <xiang.z.li@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
