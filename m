Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DFE21C86
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 19:33:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BEE421275479;
	Fri, 17 May 2019 10:33:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CC06E2125584F
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:33:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w33so11629817edb.10
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PAeoxF2imq2aUNGpWDXhVAfgD9B+GyCzgoCoPFLvAKA=;
 b=TdcT0ao8wyzDXRR3baDL1GRF+OfLNOeR9/I2TulJt5JsUQb+LG08zQI8xbNjtusE+e
 ZdO/jwAn1gUii0A+VpoQhVYNUFJMQgMXJE0jIXa7NyqzFSDSf9NlEBwhugR1g8SDpoc9
 WbyDzdPHcQ0ZQnP1eCgS/i3+C79euoCv7/5ZQdnwdUGsntWsk896+MSq9mpka1A4mHEA
 vs7k3FEOKaHSHrV1aswiHY8M1nr6xdUi4F5NL9mP9N43DNpQ15spNDa7qSYXSuu0J48r
 HD4rcSYGHFfhnNYXnCOoC7xqqMm8oJBiw2cM+dwf16YmjI611f/6JfjH7qfpPAGQhBTV
 wzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PAeoxF2imq2aUNGpWDXhVAfgD9B+GyCzgoCoPFLvAKA=;
 b=tDDjPTCppi1KzhgvF98J3ctS8fwodAqMauiCj1XHcuMEMM9ZjL1JfOXhtN+fZwb1ws
 hiMADgl4PMEbvjRCgZjK1LTov0oOLOcZ+jP1uH1CTZ1CzKiMxfbp7UXE7FktRngqgui+
 5HPZN4li0H8yBBXHAAUcSiJJo3Natem7CHMd+WGoTQ32M/AcBYQrlJTxqMBDJzQSOtTt
 fyQuiDHeZhXcx1aR7Z8tWvI48glEF8lT/q4tnBixOo7UkAmmzBJfKmE+XLhYyX3vT0Hg
 yVad/udGCpIWyTenlkV4xTcGbEYxRmOrHzeTVzTgFppKA5Zp8uOrl4jtoa/UjQo1gWDF
 9FRA==
X-Gm-Message-State: APjAAAUSZpw4zJTTgC7NLrOCJeaMe1SbbztfNCNNP+iYfXlXz8e4wszn
 A0tJEJcyhb5AwQ8ktVitbEnWWwyXMGkmJSxpRSXuPg==
X-Google-Smtp-Source: APXvYqwjJ4gypFzj7i15z2ynBCtipPcuZRluChX/vOW8Yiaed+BIB651uMRUczuoRSPU78hl+CTC5PEO5Yuy/B61iJ4=
X-Received: by 2002:a50:ee01:: with SMTP id g1mr58636495eds.263.1558114416186; 
 Fri, 17 May 2019 10:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CK2bBeOJPnnyWBgj0CJ7E1z9GVWVg_EJAmDs07BSJDp3PYfQ@mail.gmail.com>
 <20190517143816.GO6836@dhcp22.suse.cz>
 <CA+CK2bA+2+HaV4GWNUNP04fjjTPKbEGQHSPrSrmY7HLD57au1Q@mail.gmail.com>
 <CA+CK2bDq+2qu28afO__4kzO4=cnLH1P4DcHjc62rt0UtYwLm0A@mail.gmail.com>
In-Reply-To: <CA+CK2bDq+2qu28afO__4kzO4=cnLH1P4DcHjc62rt0UtYwLm0A@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 17 May 2019 13:33:25 -0400
Message-ID: <CA+CK2bCgF7z5UHqrGCYu4JgG=5o6uXbjutTo9VSYAkqu3dqn5w@mail.gmail.com>
Subject: Re: NULL pointer dereference during memory hotremove
To: Michal Hocko <mhocko@kernel.org>
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Wu,
 Fengguang" <fengguang.wu@intel.com>, "david@redhat.com" <david@redhat.com>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Huang,
 Ying" <ying.huang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jmorris@namei.org" <jmorris@namei.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "jglisse@redhat.com" <jglisse@redhat.com>,
 "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>,
 "zwisler@kernel.org" <zwisler@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "bp@suse.de" <bp@suse.de>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 17, 2019 at 1:24 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, May 17, 2019 at 1:22 PM Pavel Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Fri, May 17, 2019 at 10:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Fri 17-05-19 10:20:38, Pavel Tatashin wrote:
> > > > This panic is unrelated to circular lock issue that I reported in a
> > > > separate thread, that also happens during memory hotremove.
> > > >
> > > > xakep ~/x/linux$ git describe
> > > > v5.1-12317-ga6a4b66bd8f4
> > >
> > > Does this happen on 5.0 as well?
> >
> > Yes, just reproduced it on 5.0 as well. Unfortunately, I do not have a
> > script, and have to do it manually, also it does not happen every
> > time, it happened on 3rd time for me.
>
> Actually, sorry, I have not tested 5.0, I compiled 5.0, but my script
> still tested v5.1-12317-ga6a4b66bd8f4 build. I will report later if I
> am able to reproduce it on 5.0.

OK, confirmed on 5.0 as well, took 4 tries to reproduce:
(qemu) [   17.104486] Offlined Pages 32768
[   17.105543] Built 1 zonelists, mobility grouping on.  Total pages: 1515892
[   17.106475] Policy zone: Normal
[   17.107029] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000698
[   17.107645] #PF error: [normal kernel read fault]
[   17.108038] PGD 0 P4D 0
[   17.108287] Oops: 0000 [#1] SMP PTI
[   17.108557] CPU: 5 PID: 313 Comm: kworker/u16:5 Not tainted 5.0.0_pt_pmem1 #2
[   17.109128] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-20181126_142135-anatol 04/01/2014
[   17.109910] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[   17.110323] RIP: 0010:__remove_pages+0x2f/0x520
[   17.110674] Code: 41 56 41 55 49 89 fd 41 54 55 53 48 89 d3 48 83
ec 68 48 89 4c 24 08 65 48 8b 04 25 28 00 00 00 48 89 44 24 60 31 c0
48 89 f8 <48> 2b 47 58 48 3d 00 19 00 00 0f 85 7f 03 00 00 48 85 c9 0f
84 df
[   17.112114] RSP: 0018:ffffb43b815f3ca8 EFLAGS: 00010246
[   17.112518] RAX: 0000000000000640 RBX: 0000000000040000 RCX: 0000000000000000
[   17.113073] RDX: 0000000000040000 RSI: 0000000000240000 RDI: 0000000000000640
[   17.113615] RBP: 0000000240000000 R08: 0000000000000000 R09: 0000000040000000
[   17.114186] R10: 0000000040000000 R11: 0000000240000000 R12: ffffe382c9000000
[   17.114743] R13: 0000000000000640 R14: 0000000000040000 R15: 0000000000240000
[   17.115288] FS:  0000000000000000(0000) GS:ffff979539b40000(0000)
knlGS:0000000000000000
[   17.115911] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.116356] CR2: 0000000000000698 CR3: 0000000133c22004 CR4: 0000000000360ee0
[   17.116913] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   17.117467] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   17.118016] Call Trace:
[   17.118214]  ? memblock_isolate_range+0xc4/0x139
[   17.118570]  ? firmware_map_remove+0x48/0x90
[   17.118908]  arch_remove_memory+0x7b/0xc0
[   17.119216]  __remove_memory+0x93/0xc0
[   17.119528]  acpi_memory_device_remove+0x67/0xe0
[   17.119890]  acpi_bus_trim+0x50/0x90
[   17.120167]  acpi_device_hotplug+0x2fc/0x460
[   17.120498]  acpi_hotplug_work_fn+0x15/0x20
[   17.120834]  process_one_work+0x2a0/0x650
[   17.121146]  worker_thread+0x34/0x3d0
[   17.121432]  ? process_one_work+0x650/0x650
[   17.121772]  kthread+0x118/0x130
[   17.122032]  ? kthread_create_on_node+0x60/0x60
[   17.122413]  ret_from_fork+0x3a/0x50
[   17.122727] Modules linked in:
[   17.122983] CR2: 0000000000000698
[   17.123250] ---[ end trace 389c4034f6d42e6f ]---
[   17.123618] RIP: 0010:__remove_pages+0x2f/0x520
[   17.123979] Code: 41 56 41 55 49 89 fd 41 54 55 53 48 89 d3 48 83
ec 68 48 89 4c 24 08 65 48 8b 04 25 28 00 00 00 48 89 44 24 60 31 c0
48 89 f8 <48> 2b 47 58 48 3d 00 19 00 00 0f 85 7f 03 00 00 48 85 c9 0f
84 df
[   17.125410] RSP: 0018:ffffb43b815f3ca8 EFLAGS: 00010246
[   17.125818] RAX: 0000000000000640 RBX: 0000000000040000 RCX: 0000000000000000
[   17.126359] RDX: 0000000000040000 RSI: 0000000000240000 RDI: 0000000000000640
[   17.126906] RBP: 0000000240000000 R08: 0000000000000000 R09: 0000000040000000
[   17.127453] R10: 0000000040000000 R11: 0000000240000000 R12: ffffe382c9000000
[   17.128008] R13: 0000000000000640 R14: 0000000000040000 R15: 0000000000240000
[   17.128555] FS:  0000000000000000(0000) GS:ffff979539b40000(0000)
knlGS:0000000000000000
[   17.129182] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.129627] CR2: 0000000000000698 CR3: 0000000133c22004 CR4: 0000000000360ee0
[   17.130182] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   17.130744] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   17.131293] BUG: sleeping function called from invalid context at
include/linux/percpu-rwsem.h:34
[   17.132050] in_atomic(): 0, irqs_disabled(): 1, pid: 313, name: kworker/u16:5
[   17.132596] INFO: lockdep is turned off.
[   17.132908] irq event stamp: 14046
[   17.133175] hardirqs last  enabled at (14045): [<ffffffffadbf3b1a>]
kfree+0xba/0x230
[   17.133777] hardirqs last disabled at (14046): [<ffffffffada01b03>]
trace_hardirqs_off_thunk+0x1a/0x1c
[   17.134497] softirqs last  enabled at (13446): [<ffffffffae2c804c>]
peernet2id+0x4c/0x70
[   17.135119] softirqs last disabled at (13444): [<ffffffffae2c802d>]
peernet2id+0x2d/0x70
[   17.135739] CPU: 5 PID: 313 Comm: kworker/u16:5 Tainted: G      D
        5.0.0_pt_pmem1 #2
[   17.136389] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-20181126_142135-anatol 04/01/2014
[   17.137169] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[   17.137589] Call Trace:
[   17.137792]  dump_stack+0x67/0x90
[   17.138160]  ___might_sleep.cold.87+0x9f/0xaf
[   17.138497]  exit_signals+0x2b/0x240
[   17.138794]  do_exit+0xab/0xc10
[   17.139055]  ? process_one_work+0x650/0x650
[   17.139406]  ? kthread+0x118/0x130
[   17.139686]  rewind_stack_do_exit+0x17/0x20


# uname -a
Linux pt 5.0.0 #2 SMP Fri May 17 13:28:36 EDT 2019 x86_64 GNU/Linux
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
