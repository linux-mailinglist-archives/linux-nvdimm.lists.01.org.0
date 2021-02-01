Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7729030AD6C
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 18:10:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8DC22100EB82C;
	Mon,  1 Feb 2021 09:10:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A332100EB82B
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 09:10:54 -0800 (PST)
IronPort-SDR: WJ50SNoaSQhkp9iZx+KIbDQJB3pXg86pvPIjgH73LIRaXTV0ywSwALNGEVwW3mxaQAv9nJsg2n
 zmGkHYICeMCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="168399885"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="168399885"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:10:53 -0800
IronPort-SDR: HBYH405ROlMEXT03PmawXS4NPL/f9eJXfesa31754JNg5yULll9HHRdK5HY/0W32JLDR6YU/lE
 D8fqecKtWQ/Q==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="432430624"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:10:52 -0800
Date: Mon, 1 Feb 2021 09:10:51 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
Message-ID: <20210201171051.m3cbr3udczxwghqh@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-6-ben.widawsky@intel.com>
 <ecd93422-b272-2b76-1ec-cf6af744ae@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ecd93422-b272-2b76-1ec-cf6af744ae@google.com>
Message-ID-Hash: 2GSKAHKNBDVCWO6VPX3CS5H34NQRRCDQ
X-Message-ID-Hash: 2GSKAHKNBDVCWO6VPX3CS5H34NQRRCDQ
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2GSKAHKNBDVCWO6VPX3CS5H34NQRRCDQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-01-30 15:52:01, David Rientjes wrote:
> On Fri, 29 Jan 2021, Ben Widawsky wrote:
> 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > new file mode 100644
> > index 000000000000..fe7b87eba988
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -0,0 +1,26 @@
> > +What:		/sys/bus/cxl/devices/memX/firmware_version
> > +Date:		December, 2020
> > +KernelVersion:	v5.12
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) "FW Revision" string as reported by the Identify
> > +		Memory Device Output Payload in the CXL-2.0
> > +		specification.
> > +
> > +What:		/sys/bus/cxl/devices/memX/ram/size
> > +Date:		December, 2020
> > +KernelVersion:	v5.12
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) "Volatile Only Capacity" as reported by the
> > +		Identify Memory Device Output Payload in the CXL-2.0
> > +		specification.
> > +
> > +What:		/sys/bus/cxl/devices/memX/pmem/size
> > +Date:		December, 2020
> > +KernelVersion:	v5.12
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) "Persistent Only Capacity" as reported by the
> > +		Identify Memory Device Output Payload in the CXL-2.0
> > +		specification.
> 
> Aren't volatile and persistent capacities expressed in multiples of 256MB?

As of the spec today, volatile and persistent capacities are required to be
in multiples of 256MB, however, future specs may not have such a requirement and
I think keeping sysfs ABI easily forward portable makes sense.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
