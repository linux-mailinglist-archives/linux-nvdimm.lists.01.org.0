Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A142E741CF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Jul 2019 01:05:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE6CE212DC5DC;
	Wed, 24 Jul 2019 16:07:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3C06621959CB2
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 16:07:38 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jul 2019 16:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,304,1559545200"; d="scan'208";a="369454607"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2019 16:05:11 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 24 Jul 2019 16:05:11 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.100]) by
 FMSMSX112.amr.corp.intel.com ([169.254.5.121]) with mapi id 14.03.0439.000;
 Wed, 24 Jul 2019 16:05:10 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v6 07/13] daxctl: add a new reconfigure-device
 command
Thread-Topic: [ndctl PATCH v6 07/13] daxctl: add a new reconfigure-device
 command
Thread-Index: AQHVPPKNqISvx0f5ZkaZH57ienJYYaba32EAgAAEjYA=
Date: Wed, 24 Jul 2019 23:05:09 +0000
Message-ID: <71c4202212fc6da02a0f80caaf0c1a5d080f6cf8.camel@intel.com>
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
 <20190717225400.9494-8-vishal.l.verma@intel.com>
 <CAPcyv4jcOZUyQQUZWuNp5+K+ciifg4hHSRhRk4PP1-MtKMebhQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jcOZUyQQUZWuNp5+K+ciifg4hHSRhRk4PP1-MtKMebhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <DF866F3EF1F1964391FC6EA18F470220@intel.com>
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

On Wed, 2019-07-24 at 15:48 -0700, Dan Williams wrote:
> On Wed, Jul 17, 2019 at 3:54 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > Add a new command 'daxctl-reconfigure-device'. This is used to switch
> > the mode of a dax device between regular 'device_dax' and
> > 'system-memory'. The command also uses the memory hotplug sysfs
> > interfaces to online the newly available memory when converting to
> > 'system-ram', and to attempt to offline the memory when converting back
> > to a DAX device.
> > 
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > ---
> >  daxctl/Makefile.am |   2 +
> >  daxctl/builtin.h   |   1 +
> >  daxctl/daxctl.c    |   1 +
> >  daxctl/device.c    | 348 +++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 352 insertions(+)
> >  create mode 100644 daxctl/device.c
> > 
[..]
> > +       case ACTION_RECONFIG:
> > +               if (!param.mode) {
> > +                       fprintf(stderr, "error: a 'mode' option is required\n");
> > +                       usage_with_options(u, reconfig_options);
> > +                       rc = -EINVAL;
> > +               }
> > +               if (strcmp(param.mode, "system-ram") == 0) {
> > +                       reconfig_mode = DAXCTL_DEV_MODE_RAM;
> > +                       if (param.do_offline) {
> > +                               fprintf(stderr,
> > +                                       "can't --attempt-offline for system-ram mode\n");
> 
> I'm not sure I grok the --attempt-offline option. That seems like it
> belongs to its own command, and is required to succeed before daxctl
> disable-device. Or is this like a "--force" to disable and cleanup
> system-ram mode before moving to devdax mode. If it's the latter I'd
> prefer that was a --force option. Otherwise, the error message "can't
> --attempt-offline for system-ram mode\n" is confusing because
> offlining only makes sense for system-ram mode.

Yes it is like the --force option to other disable/destroy commands - I
agree that's clearer. I'll change it.

> 
> > +                               rc = -EINVAL;
> > +                       }
> > +               } else if (strcmp(param.mode, "devdax") == 0) {
> > +                       reconfig_mode = DAXCTL_DEV_MODE_DEVDAX;
> > +                       if (param.no_online) {
> > +                               fprintf(stderr,
> > +                                       "can't --no-online for devdax mode\n");
> 
> How about "--no-online option incompatible with --mode=devdax"?

Sounds good.

> 
> > +                               rc =  -EINVAL;
> > +                       }
> > +               }
> > +               break;
> > +       }
> > +       if (rc) {
> > +               usage_with_options(u, options);
> > +               return NULL;
> > +       }
> > +
> > +       return argv[0];
> > +}
> > +
> > +static int disable_devdax_device(struct daxctl_dev *dev)
> > +{
> > +       const char *devname = daxctl_dev_get_devname(dev);
> > +       enum daxctl_dev_mode mode;
> > +       int rc;
> > +
> > +       mode = daxctl_dev_get_mode(dev);
> > +       if (mode < 0) {
> > +               fprintf(stderr, "%s: unable to determine current mode: %s\n",
> > +                       devname, strerror(-mode));
> > +               return mode;
> > +       }
> > +       if (mode == DAXCTL_DEV_MODE_RAM) {
> > +               fprintf(stderr, "%s is in system-ram mode, nothing to do\n",
> > +                       devname);
> 
> "Nothing to do" implies "it is already disabled", this is just "not
> supported" until integrating with v5.3, right?

It implies that we are already in system-ram mode when --mode=system-ram 
was asked, and there really is nothing to do. Except possibly online the
memory if it is not online, and we still do that down below. We don't
really attempt to detect the v5.3 hot-remove support - if it is not
present, the removal will simply fail.

> 
> > +               return 1;
> > +       }
> > +       rc = daxctl_dev_disable(dev);
> > +       if (rc) {
> > +               fprintf(stderr, "%s: disable failed: %s\n",
> > +                       daxctl_dev_get_devname(dev), strerror(-rc));
> > +               return rc;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int reconfig_mode_system_ram(struct daxctl_dev *dev)
> > +{
> > +       struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> > +       const char *devname = daxctl_dev_get_devname(dev);
> > +       int rc, skip_enable = 0;
> > +
> > +       if (daxctl_dev_is_enabled(dev)) {
> > +               rc = disable_devdax_device(dev);
> > +               if (rc < 0)
> > +                       return rc;
> > +               if (rc > 0)
> > +                       skip_enable = 1;
> > +       }
> > +
> > +       if (!skip_enable) {
> > +               rc = daxctl_dev_enable_ram(dev);
> > +               if (rc)
> > +                       return rc;
> > +       }
> > +
> > +       if (param.no_online)
> > +               return 0;
> > +
> > +       rc = daxctl_memory_set_online(mem);
> > +       if (rc < 0) {
> > +               fprintf(stderr, "%s: unable to online memory: %s\n",
> 
> s/unable/failed/
> 
> I didn't comment earlier, but if it's not too late I think
> 'daxctl_memory_{on,off}line()' is sufficient, no need for 'set_'.

Yep, will change both.

> 
> > +                       devname, strerror(-rc));
> > +               return rc;
> > +       }
> > +       if (param.verbose)
> > +               fprintf(stderr, "%s: onlined %d memory sections\n",
> > +                       devname, rc);
> > +
> > +       return 0;
> > +}
> > +
> > +static int disable_system_ram_device(struct daxctl_dev *dev)
> > +{
> > +       struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> > +       const char *devname = daxctl_dev_get_devname(dev);
> > +       enum daxctl_dev_mode mode;
> > +       int rc;
> > +
> > +       mode = daxctl_dev_get_mode(dev);
> > +       if (mode < 0) {
> > +               fprintf(stderr, "%s: unable to determine current mode: %s\n",
> > +                       devname, strerror(-mode));
> 
> When would this happen in practice? I can only think it would happen
> when using the old device model in which case we could fall through to
> the "already in devdax mode" case.

Right with the v7 .._get_memory() interface to detect the mode, this
goes away.

> 
> > +               return mode;
> > +       }
> > +       if (mode == DAXCTL_DEV_MODE_DEVDAX) {
> > +               fprintf(stderr, "%s: already in devdax mode, nothing to do\n",
> > +                       devname);
> > +               return 1;
> > +       }
> > +
> > +       if (param.do_offline) {
> > +               rc = daxctl_memory_set_offline(mem);
> > +               if (rc < 0) {
> > +                       fprintf(stderr, "%s: unable to offline memory: %s\n",
> 
> s/unable/failed/
> 
> ...and same comment about dropping '_set'. Is there an api to retrieve
> the number of memory blocks / sections behind daxctl_memory instance?
> Then you could also check for the number of sections offlined < total
> sections case. The most likely case is that a single section is
> holding up the offline process and someone might want to interrogate
> which one that is relative to the device instance.

There is not an interface to query the number of blocks directly, but if
we fail to online/offline a given memblock, we print it in debug/verbose
logging. It wouldn't be too hard to add an interface to get the total
number of blocks, but it would still be hard for the daxctl side to
determine /which/ block it was, as it is only libdaxctl that loops
through all the blocks and sets their state (so to find which one would
have to go to the debug logs anyway). I think there is still value in
letting the user know that something unexpected happened - I can look
into adding that.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
