Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D9774D1
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 01:14:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56F0F212E1597;
	Fri, 26 Jul 2019 16:16:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 385DF212E158B
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 16:16:37 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jul 2019 16:14:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,312,1559545200"; d="scan'208";a="194443004"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2019 16:14:10 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jul 2019 16:14:10 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.100]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.168]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 16:14:09 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v7 08/13] Documentation/daxctl: add a man page for
 daxctl-reconfigure-device
Thread-Topic: [ndctl PATCH v7 08/13] Documentation/daxctl: add a man page
 for daxctl-reconfigure-device
Thread-Index: AQHVQmrbc0UkxV05Kk+1Ul93QvkUVqbcqRiAgAFXE4A=
Date: Fri, 26 Jul 2019 23:14:09 +0000
Message-ID: <23086b510a48eeb88fac4e71f334c94bb12dc174.camel@intel.com>
References: <20190724215741.18556-1-vishal.l.verma@intel.com>
 <20190724215741.18556-9-vishal.l.verma@intel.com>
 <CAPcyv4h=i_EJD425mRUzpCdppiwA6CN3FmC0u3thvkMy4aajWg@mail.gmail.com>
In-Reply-To: <CAPcyv4h=i_EJD425mRUzpCdppiwA6CN3FmC0u3thvkMy4aajWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <A1FA0CBAE918F040943927D02A7B537E@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 2019-07-25 at 19:46 -0700, Dan Williams wrote:
> On Wed, Jul 24, 2019 at 2:57 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > Add a man page describing the new daxctl-reconfigure-device command.
> > 
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > ---
> >  Documentation/daxctl/Makefile.am              |   3 +-
> >  .../daxctl/daxctl-reconfigure-device.txt      | 139 ++++++++++++++++++
> >  2 files changed, 141 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/daxctl/daxctl-reconfigure-device.txt
> > 
[..]
> > +* Run a process called 'some-service' using numactl to restrict its cpu
> > +nodes to '0' and '1', and  memory allocations to node 2 (determined using
> > +daxctl_dev_get_target_node() or 'daxctl list')
> > +----
> > +# daxctl reconfigure-device --mode=system-ram --no-online dax0.0
> 
> Any reason to use --no-online in this example? Presumably some-service
> may not start if node2 has no online memory.
> 
Yep just a copy/paste typo, removing it.
> 
> > +[
> > +  {
> > +    "chardev":"dax0.0",
> > +    "size":16777216000,
> > +    "target_node":2,
> > +    "mode":"system-ram"
> > +  }
> > +]
> > +
> > +# numactl --cpunodebind=0-1 --membind=2 -- some-service --opt1 --opt2
> > +----
> > +
> > +DESCRIPTION
> > +-----------
> > +
> > +Reconfigure the operational mode of a dax device. This can be used to convert
> > +a regular 'devdax' mode device to the 'system-ram' mode which allows for the dax
> 
> s/allows/arranges/

ok.

> 
> > +range to be hot-plugged into the system as regular memory.
> > +
> > +NOTE: This is a destructive operation. Any data on the dax device *will* be
> > +lost.
> > +
> > +NOTE: Device reconfiguration depends on the dax-bus device model. If dax-class is
> > +in use (via the dax_pmem_compat driver), the reconfiguration will fail. See
> > +linkdaxctl:daxctl-migrate-device-model[1] for more information.
> 
> Let's make sure that do_reconfig() bails with a common error message
> for the compat case and quote that message here. You can check that by
> comparing the device path 'subsystem' to /sys/class/dax. I.e.
> 
> # ls -l /dev/dax0.0
> crw------- 1 root root 253, 4 Jul 25 12:22 /dev/dax0.0
> 
> # readlink -f /sys/dev/char/253\:4/subsystem
> /sys/class/dax
> 
> ...it will be /sys/bus/dax otherwise.

Hm,. currently the failure is just:
libdaxctl: daxctl_dev_enable: dax3.0: failed to enable

Should we check the subsystem as above programatically, and print a
better error in daxctl-reconfigure-device?

> 
> > +
> > +OPTIONS
> > +-------
> > +-r::
> > +--region=::
> > +       Restrict the operation to devices belonging to the specified region(s).
> > +       A device-dax region is a contiguous range of memory that hosts one or
> > +       more /dev/daxX.Y devices, where X is the region id and Y is the device
> > +       instance id.
> > +
> > +-m::
> > +--mode=::
> > +       Specify the mode to which the dax device(s) should be reconfigured.
> > +       - "system-ram": hotplug the device into system memory.
> > +
> > +       - "devdax": switch to the normal "device dax" mode. This requires the
> > +         kernel to support hot-unplugging 'kmem' based memory. If this is not
> > +         available, a reboot is the only way to switch back to 'devdax' mode.
> > +
> > +-N::
> > +--no-online::
> > +       By default, memory sections provided by system-ram devices will be
> > +       brought online automatically and immediately with the 'online_movable'
> > +       policy. Use this option to disable the automatic onlining behavior.
> 
> Probably need to mention that the system might online the memory even
> if this is specified, or for extra credit, coordinate with that
> auto-online facility to arrange for it to be skipped.

Good point, added a note regarding this.

> 
> > +
> > +-O::
> > +--attempt-offline::
> > +       When converting from "system-ram" mode to "devdax", it is expected
> > +       that all the memory sections are first made offline. By default,
> > +       daxctl won't touch online memory. However with this option, attempt
> > +       to offline the memory on the NUMA node associated with the dax device
> > +       before converting it back to "devdax" mode.
> 
> As mentioned in patch 7, this sounds like --force to me.

Done.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
