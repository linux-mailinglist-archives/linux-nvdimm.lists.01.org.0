Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EFD3187BB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 11:07:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33EF4100EA92F;
	Thu, 11 Feb 2021 02:07:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4B92C100EA929
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 02:07:51 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dbsd6739dz67mrk;
	Thu, 11 Feb 2021 18:02:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 11:07:48 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 10:07:47 +0000
Date: Thu, 11 Feb 2021 10:06:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Message-ID: <20210211100646.00007dcc@Huawei.com>
In-Reply-To: <CAPcyv4hRUB3jxdCV06y0kYMbKbGroEW6F9yOQ4KB_z6YgWBZ4Q@mail.gmail.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
	<20210210000259.635748-5-ben.widawsky@intel.com>
	<20210210184540.00007536@Huawei.com>
	<CAPcyv4hRUB3jxdCV06y0kYMbKbGroEW6F9yOQ4KB_z6YgWBZ4Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: X6MJWO54UMDO6FSYOGCIKQNQM47XNCHY
X-Message-ID-Hash: X6MJWO54UMDO6FSYOGCIKQNQM47XNCHY
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
	"Linux ACPI  <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig" <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"David Rientjes  <rientjes@google.com>,  Jon Masters" <jcm@jonmasters.org>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Randy Dunlap  <rdunlap@infradead.org>,  John Groves  (jgroves)" <jgroves@micron.com>,
	"Kelley, Sean V" <sean.v.kelley@intel.com>, kernel@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X6MJWO54UMDO6FSYOGCIKQNQM47XNCHY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 10 Feb 2021 20:40:52 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Feb 10, 2021 at 10:47 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> [..]
> > > +#define CXL_CMDS                                                          \
> > > +     ___C(INVALID, "Invalid Command"),                                 \
> > > +     ___C(IDENTIFY, "Identify Command"),                               \
> > > +     ___C(MAX, "Last command")
> > > +
> > > +#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > > +enum { CXL_CMDS };
> > > +
> > > +#undef ___C
> > > +#define ___C(a, b) { b }
> > > +static const struct {
> > > +     const char *name;
> > > +} cxl_command_names[] = { CXL_CMDS };
> > > +#undef ___C  
> >
> > Unless there are going to be a lot of these, I'd just write them out long hand
> > as much more readable than the macro magic.  
> 
> This macro magic isn't new to Linux it was introduced with ftrace:
> 
> See "cpp tricks and treats": https://lwn.net/Articles/383362/

Yeah. I've dealt with that one a few times. It's very cleaver and compact
but a PITA to debug build errors related to it.

> 
> >
> > enum {
> >         CXL_MEM_COMMAND_ID_INVALID,
> >         CXL_MEM_COMMAND_ID_IDENTIFY,
> >         CXL_MEM_COMMAND_ID_MAX
> > };
> >
> > static const struct {
> >         const char *name;
> > } cxl_command_names[] = {
> >         [CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
> >         [CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Comamnd" },
> >         /* I hope you never need the Last command to exist in here as that sounds like a bug */
> > };
> >
> > That's assuming I actually figured the macro fun out correctly.
> > To my mind it's worth doing this stuff for 'lots' no so much for 3.  
> 
> The list will continue to expand, and it eliminates the "did you
> remember to update cxl_command_names" review burden permanently.

How about a compromise.  Add a comment giving how the first entry expands to
avoid people (me at least :) having to think their way through it every time?

Jonathan
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
