Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCDC206887
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 01:38:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0AE2C10FC447E;
	Tue, 23 Jun 2020 16:38:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E3BB210FC3C35
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 16:38:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so99556edb.3
        for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+5DEpU8MPUbZ6qwtbZiaceci+Pn8MEakpjQ5eTQOsI=;
        b=BwUqHklfO/CutrJi4sSum+0Oq/aYqJfREtlUlYvFqbg7C2o95ZsY+aAXTx7fNIqRlM
         Om074BwZAmcoci+DUnxoZzH3aUY868XxJQ3e+6JDyQEeC5iWZeGHiE70uuI/atB1cNom
         xCXyVRlG/BG+Rk5xaw7GbqzulJ1j6coo4t2CZwbOL2cZm9+rBLrxB8B9p4DdnTG5jBOR
         QOAJ0t25Rb7Yshr94RCpaZRQfmpGRLjm10NrzcoQauH2bK0ogXDlXycuJivzDLWf2kpl
         Gn4kSiTKiGrLyb2dt9L3qvS4RYk5JmJUO1YPrBkKVpK/5pye8XDZdSTLgh373wVJZ+jb
         d8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+5DEpU8MPUbZ6qwtbZiaceci+Pn8MEakpjQ5eTQOsI=;
        b=nP+WTcss/EOk9y1wlA8nF6QAnUR7fBDgkc0r/AjDNj3wcx7ZIfETQddowbO68HyPgB
         8o/I7gO1jcOP6O8klapDmKBjEXHUH+J2rfRt5Tex0ofldNtk75YOjHTCyIgYR5wmoEdL
         htVLOPytVyTUB9lBEtV78qmp7rJFeNntpYLYB3Uxft9uJJJfgz50pdma7rnQPiR7HloG
         Gil73xQJ5R8wNHCncnhsrNoGraavXwvLrE1Q0u1UQ/iM5lG3/LZJZuvwC8dDmTltkwBs
         VE+QYBsyp2r+MDVkdydbNQJc+IbY3w2otg6XK8Pak81WIOxmwKcpM0cfbtccyJEHAAR/
         atXQ==
X-Gm-Message-State: AOAM530neaPi0Rb/GFVtPL0PNwATeIU+xyMRwyjd520LNs+W27veDmDe
	ccF//OXr2WHcXOeSYHXfyWgRMcEoV/E4Uq3xvh7SjH4m
X-Google-Smtp-Source: ABdhPJwasF7vLiirxOKWGUzsRqmUk8WOnFuNI5R6Wx/5Z8Z+01/3A8rY2PQo2WH9IbTfWRuQy6ZyR4TfT8v3+uoVWY4=
X-Received: by 2002:a05:6402:459:: with SMTP id p25mr23770678edw.383.1592955520956;
 Tue, 23 Jun 2020 16:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
In-Reply-To: <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Jun 2020 16:38:29 -0700
Message-ID: <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>
Message-ID-Hash: ZDYC3MK6SKGF4MFZU7FWVV2FBG7WLBYN
X-Message-ID-Hash: ZDYC3MK6SKGF4MFZU7FWVV2FBG7WLBYN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "raven@themaw.net" <raven@themaw.net>, "kzak@redhat.com" <kzak@redhat.com>, "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dray@redhat.com" <dray@redhat.com>, "swhiteho@redhat.com" <swhiteho@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>, "jlayton@redhat.com" <jlayton@redhat.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "andres@anarazel.de" <andres@anarazel.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZDYC3MK6SKGF4MFZU7FWVV2FBG7WLBYN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 16, 2020 at 6:15 PM Williams, Dan J
<dan.j.williams@intel.com> wrote:
>
> Hi David,
>
> On Tue, 2020-06-02 at 16:55 +0100, David Howells wrote:
> > Date: Tue, 02 Jun 2020 16:51:44 +0100
> >
> > Hi Linus,
> >
> > Can you pull this, please?  It adds a general notification queue
> > concept
> > and adds an event source for keys/keyrings, such as linking and
> > unlinking
> > keys and changing their attributes.
> [..]
>
> This commit:
>
> >       keys: Make the KEY_NEED_* perms an enum rather than a mask
>
> ...upstream as:
>
>     8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a mask
>
> ...triggers a regression in the libnvdimm unit test that exercises the
> encrypted keys used to store nvdimm passphrases. It results in the
> below warning.

This regression is still present in tip of tree. David, have you had a
chance to take a look?



>
> ---
>
> WARNING: CPU: 15 PID: 6276 at security/keys/permission.c:35 key_task_permission+0xd3/0x140
> Modules linked in: nd_blk(OE) nfit_test(OE) device_dax(OE) ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) kvm_intel(E) kvm(E) irqbypass(E) nd_pmem(OE) dax_pmem(OE) nd_btt(OE) dax_p
> ct10dif_pclmul(E) nd_e820(OE) nfit(OE) crc32_pclmul(E) libnvdimm(OE) crc32c_intel(E) ghash_clmulni_intel(E) serio_raw(E) encrypted_keys(E) trusted(E) nfit_test_iomap(OE) tpm(E) drm(E)
> CPU: 15 PID: 6276 Comm: lt-ndctl Tainted: G           OE     5.7.0-rc6+ #155
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> RIP: 0010:key_task_permission+0xd3/0x140
> Code: c8 21 d9 39 d9 75 25 48 83 c4 08 4c 89 e6 48 89 ef 5b 5d 41 5c 41 5d e9 1b a7 00 00 bb 01 00 00 00 83 fa 01 0f 84 68 ff ff ff <0f> 0b 48 83 c4 08 b8 f3 ff ff ff 5b 5d 41 5c 41 5d c3 83 fa 06
>
> RSP: 0018:ffffaddc42db7c90 EFLAGS: 00010297
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffaddc42db7c7c
> RDX: 0000000000000000 RSI: ffff985e1c46e840 RDI: ffff985e3a03de01
> RBP: ffff985e3a03de01 R08: 0000000000000000 R09: 5461e7bc000002a0
> R10: 0000000000000004 R11: 0000000066666666 R12: ffff985e1c46e840
> R13: 0000000000000000 R14: ffffaddc42db7cd8 R15: ffff985e248c6540
> FS:  00007f863c18a780(0000) GS:ffff985e3bbc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006d3708 CR3: 0000000125a1e006 CR4: 0000000000160ee0
> Call Trace:
>  lookup_user_key+0xeb/0x6b0
>  ? vsscanf+0x3df/0x840
>  ? key_validate+0x50/0x50
>  ? key_default_cmp+0x20/0x20
>  nvdimm_get_user_key_payload.part.0+0x21/0x110 [libnvdimm]
>  nvdimm_security_store+0x67d/0xb20 [libnvdimm]
>  security_store+0x67/0x1a0 [libnvdimm]
>  kernfs_fop_write+0xcf/0x1c0
>  vfs_write+0xde/0x1d0
>  ksys_write+0x68/0xe0
>  do_syscall_64+0x5c/0xa0
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x7f863c624547
> Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007ffd61d8f5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffd61d8f640 RCX: 00007f863c624547
> RDX: 0000000000000014 RSI: 00007ffd61d8f640 RDI: 0000000000000005
> RBP: 0000000000000005 R08: 0000000000000014 R09: 00007ffd61d8f4a0
> R10: fffffffffffff455 R11: 0000000000000246 R12: 00000000006dbbf0
> R13: 00000000006cd710 R14: 00007f863c18a6a8 R15: 00007ffd61d8fae0
> irq event stamp: 36976
> hardirqs last  enabled at (36975): [<ffffffff9131fa40>] __slab_alloc+0x70/0x90
> hardirqs last disabled at (36976): [<ffffffff910049c7>] trace_hardirqs_off_thunk+0x1a/0x1c
> softirqs last  enabled at (35474): [<ffffffff91e00357>] __do_softirq+0x357/0x466
> softirqs last disabled at (35467): [<ffffffff910eae96>] irq_exit+0xe6/0xf0
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
