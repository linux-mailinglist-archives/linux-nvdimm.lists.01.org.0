Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D80319068
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 17:54:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73153100EA92F;
	Thu, 11 Feb 2021 08:54:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F2BB1100ED4A4
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 08:54:17 -0800 (PST)
IronPort-SDR: 5p7gSLM9gqgljeGBXBOwN6FIcXJUcEGh/Crl3wJXkVRX6e1Id4sEwy2JcEfKHV4LQexUa88K3S
 X+ZQCKMUVlEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="182408551"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400";
   d="scan'208";a="182408551"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 08:54:17 -0800
IronPort-SDR: eqa7Zt7LeUeFWr07RwW6Yo3OMmzIqxQ7k3HTy++wEpIlr3FG91G5Y0vNTl0ZXVnN7aN+toi7f1
 IJHL3eBkFpKw==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400";
   d="scan'208";a="380757905"
Received: from reknight-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.254])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 08:54:16 -0800
Date: Thu, 11 Feb 2021 08:54:14 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Message-ID: <20210211165414.wwsu63lhoznzrhof@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com>
 <20210210184540.00007536@Huawei.com>
 <CAPcyv4hRUB3jxdCV06y0kYMbKbGroEW6F9yOQ4KB_z6YgWBZ4Q@mail.gmail.com>
 <20210211100646.00007dcc@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210211100646.00007dcc@Huawei.com>
Message-ID-Hash: P2S57Q2FXQPIEAFFLWT73LYSUVEL2SQF
X-Message-ID-Hash: P2S57Q2FXQPIEAFFLWT73LYSUVEL2SQF
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, "Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>, "Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Dan Williams <dan.j.willams@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-11 10:06:46, Jonathan Cameron wrote:
> On Wed, 10 Feb 2021 20:40:52 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Wed, Feb 10, 2021 at 10:47 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > [..]
> > > > +#define CXL_CMDS                                                          \
> > > > +     ___C(INVALID, "Invalid Command"),                                 \
> > > > +     ___C(IDENTIFY, "Identify Command"),                               \
> > > > +     ___C(MAX, "Last command")
> > > > +
> > > > +#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > > > +enum { CXL_CMDS };
> > > > +
> > > > +#undef ___C
> > > > +#define ___C(a, b) { b }
> > > > +static const struct {
> > > > +     const char *name;
> > > > +} cxl_command_names[] = { CXL_CMDS };
> > > > +#undef ___C  
> > >
> > > Unless there are going to be a lot of these, I'd just write them out long hand
> > > as much more readable than the macro magic.  
> > 
> > This macro magic isn't new to Linux it was introduced with ftrace:
> > 
> > See "cpp tricks and treats": https://lwn.net/Articles/383362/
> 
> Yeah. I've dealt with that one a few times. It's very cleaver and compact
> but a PITA to debug build errors related to it.
> 
> > 
> > >
> > > enum {
> > >         CXL_MEM_COMMAND_ID_INVALID,
> > >         CXL_MEM_COMMAND_ID_IDENTIFY,
> > >         CXL_MEM_COMMAND_ID_MAX
> > > };
> > >
> > > static const struct {
> > >         const char *name;
> > > } cxl_command_names[] = {
> > >         [CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
> > >         [CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Comamnd" },
> > >         /* I hope you never need the Last command to exist in here as that sounds like a bug */
> > > };
> > >
> > > That's assuming I actually figured the macro fun out correctly.
> > > To my mind it's worth doing this stuff for 'lots' no so much for 3.  
> > 
> > The list will continue to expand, and it eliminates the "did you
> > remember to update cxl_command_names" review burden permanently.
> 
> How about a compromise.  Add a comment giving how the first entry expands to
> avoid people (me at least :) having to think their way through it every time?
> 
> Jonathan
> 

A minor tweak while here...

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 655fbfde97fd..dac0adb879ec 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -22,7 +22,7 @@
 #define CXL_CMDS                                                          \
        ___C(INVALID, "Invalid Command"),                                 \
        ___C(IDENTIFY, "Identify Command"),                               \
-       ___C(MAX, "Last command")
+       ___C(MAX, "invalid / last command")

 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
 enum { CXL_CMDS };
@@ -32,6 +32,17 @@ enum { CXL_CMDS };
 static const struct {
        const char *name;
 } cxl_command_names[] = { CXL_CMDS };
+
+/*
+ * Here's how this actually breaks out:
+ * cxl_command_names[] = {
+ *     [CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
+ *     [CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Comamnd" },
+ *     ...
+ *     [CXL_MEM_COMMAND_ID_MAX] = { "invalid / last command" },
+ * };
+ */
+
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
