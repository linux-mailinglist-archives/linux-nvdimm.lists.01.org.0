Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A834187B20
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Mar 2020 09:26:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 771DA1007A84E;
	Tue, 17 Mar 2020 01:27:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A8FA21007B8FA
	for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 01:27:11 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s15so20763322otq.8
        for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hT/CAf4zGkaYiRXPe3bHr9RmF0jeDMTC/HqIfexHmlU=;
        b=YCfBe1erWI6/K01UV/G9/1aegxKTOBPVxWS+A4tmzQ4hsTPPUQPJD00dKX1578IvM8
         QbnBNYey6VCKsHWiL+dlqO77FVs/pHf5CKbjz0Rm6VCNjxYHrUsJR9rQyagI7TOLcHXn
         TdYUNfmeQY01WTZM0bpc3vlWIv1M5i5B1Jdls/aD48qxUkc2IGETuduvrhQFGLVPv3CK
         9PAB6FnK4utFsWoyJba9pRDRfBU80IGeeqtFtU69CSGzZ3V9oT5JV6BA6l5UPZAfV2up
         yb9jQ385TBQHKZyrrIGil3QEP/1Yfq31lEVjZL9I/p4vnX09UMcEl7FG4voss0P0R03L
         60Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hT/CAf4zGkaYiRXPe3bHr9RmF0jeDMTC/HqIfexHmlU=;
        b=WuHokRxdIAJp0qAOMFssr16fM8elslOCerxBDjsZli7kYAqqEIbNFjRfaHg+dKf7uy
         AcqT+MDVL9tLmiZ+uohMFuZndQO7RbuvT9KEcCsLHukklBgIdnmEdXWgS0I/xuOxoLbH
         /8cq5g1Ju/mzRRPSHMCZVlA6nzUjli7NxYI/WcH4iE+LBpbSlWe1xeWY9BOXd8UlnOuP
         rIMynh8PZwncodcQHBYm7RqPnBxsyshhIWawbQdUdxtuZEOOayIxUxOVSzd6KP/fXOSU
         mHR1z9L2a/QPX0ptotvNuoRl23ZGHyakqvq+ohTGtBrGIUTs7gvCJLbkokNZ/yrTe3/u
         vNZQ==
X-Gm-Message-State: ANhLgQ125Srx51Oaa4b1wFwTGXpT7CrIxuWv2VN3fv5aRopR2Cq9HcUr
	Bd0vEaLDZGjjUph1Oq1VQB14z4nIzlZQ09LN8MgTUQ==
X-Google-Smtp-Source: ADFU+vuzG5eqj+rgY/MuVhEokDc2QhejGKJYDotViFelA03Iv3mAhwRYh8roiLzFDni2VS0VVWQBhlZ85/3VlaO04Rc=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr2602777otq.247.1584433579160;
 Tue, 17 Mar 2020 01:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <SN6PR11MB28641D4A1AF433086764A98D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <SN6PR11MB2864BBFAA6EC62A7747F9E5D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4gXZKPyqu+9JmWuivw4Yuc05_Q+bbcjRAsHK2PWKtjwjg@mail.gmail.com>
 <SN6PR11MB286493B9A749705B8A107F4396FA0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4jOuTXdNzUTSj2EWBoKJ5V8FeEWo4cCA3e95jdT3=7XFQ@mail.gmail.com> <SN6PR11MB28647B2D8B3C0729FE0CCDD696F90@SN6PR11MB2864.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB28647B2D8B3C0729FE0CCDD696F90@SN6PR11MB2864.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 17 Mar 2020 01:26:08 -0700
Message-ID: <CAPcyv4iAJbZpKYzA5SgGcH+dkPQyHkxgGgufTd_YnSZ5bF_X7A@mail.gmail.com>
Subject: Re: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
To: "Dorau, Lukasz" <lukasz.dorau@intel.com>
Message-ID-Hash: PFHDAWWRG6CL7LTRQWJPGWMSY62ZDTC3
X-Message-ID-Hash: PFHDAWWRG6CL7LTRQWJPGWMSY62ZDTC3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PFHDAWWRG6CL7LTRQWJPGWMSY62ZDTC3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 16, 2020 at 1:58 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
>
> On Friday, March 13, 2020 4:50 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > On Fri, Mar 13, 2020 at 3:06 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
> > >
> > > The steps to reproduce:
> > >
> > > $ sudo modprobe -v nfit_test
> > > insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/kernel/drivers/char/hw_random/rng-core.ko.xz
> > > insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/kernel/drivers/char/tpm/tpm.ko.xz
> > > insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/kernel/security/keys/trusted-keys/trusted.ko.xz
> > > insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/kernel/security/keys/encrypted-keys/encrypted-keys.ko.xz
> > > install /usr/bin/ndctl load-keys ; /sbin/modprobe --ignore-install libnvdimm
> > $CMDLINE_OPTS
> > > No TPM handle discovered.
> > > failed to open file /etc/ndctl/keys/nvdimm-master.blob: No such file or directory
> > > insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/kernel/drivers/nvdimm/libnvdimm.ko.xz
> > > insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> > > insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/extra/test/nfit_test_iomap.ko.xz
> > > insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
> > > modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or
> > unknown parameter (see dmesg)
> > >
> > > $ dmesg | tail
> > > [  102.769871] Key type encrypted registered
> > > [  102.799289] nfit_test_iomap: loading out-of-tree module taints kernel.
> > > [  102.804008] nfit_test: Unknown symbol libnvdimm_test (err -2)
> > > [  102.804054] nfit_test: Unknown symbol acpi_nfit_test (err -2)
> > > [  102.804118] nfit_test: Unknown symbol pmem_test (err -2)
> > > [  102.804164] nfit_test: Unknown symbol dax_pmem_core_test (err -2)
> > > [  102.804226] nfit_test: Unknown symbol dax_pmem_compat_test (err -2)
> > > [  102.804273] nfit_test: Unknown symbol device_dax_test (err -2)
> > > [  102.804308] nfit_test: Unknown symbol dax_pmem_test (err -2)
> > >
> > > Removing the wrong modules:
> > >
> > > $ sudo rmmod nfit
> > > $ sudo rmmod libnvdimm
> > >
> > > Inserting the right modules manually:
> > >
> > > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/extra/libnvdimm.ko.xz
> > > $ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nd_btt.ko.xz
> > > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/extra/nd_pmem.ko.xz
> > > $ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nfit.ko.xz
> > > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/extra/dax_pmem_core.ko.xz
> > > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/extra/dax_pmem.ko.xz
> > > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/extra/device_dax.ko.xz
> > > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/extra/dax_pmem_compat.ko.xz
> > > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/extra/test/nfit_test.ko.xz
> > >
> > > The 'nfit_test' module is successfully inserted with *NO ERRORS* now:
> > >
> > > $ dmesg | tail
> > > [  464.439504] nfit_test: mcsafe_test: disabled, skip.
> > > [  464.500439] nfit_test nfit_test.0: failed to evaluate _FIT
> > > [  464.507964] nfit_test nfit_test.1: Error found in NVDIMM nmem4 flags: save_fail
> > restore_fail flush_fail not_armed
> > > [  464.507990] nfit_test nfit_test.1: Error found in NVDIMM nmem5 flags: map_fail
> > > [  464.508614] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-
> > only
> > > [  464.508729] pmem6: detected capacity change from 0 to 33554432
> > > [  464.508737] pmem7: detected capacity change from 0 to 4194304
> > >
> > > $ lsmod | grep nfit
> > > nfit_test              49152  8
> > > dax_pmem_compat        20480  1 nfit_test
> > > device_dax             20480  2 nfit_test,dax_pmem_compat
> > > dax_pmem               20480  1 nfit_test
> > > dax_pmem_core          20480  3 dax_pmem,nfit_test,dax_pmem_compat
> > > nfit                   73728  1 nfit_test
> > > nd_pmem                24576  1 nfit_test
> > > libnvdimm             200704  8
> > dax_pmem,nfit_test,dax_pmem_core,nd_btt,nd_pmem,dax_pmem_compat,nd_blk,
> > nfit
> > > nfit_test_iomap        24576  6
> > nfit_test,dax_pmem_core,device_dax,nd_pmem,libnvdimm,nfit
> > >
> > > Trying to remove and reinsert the 'nfit_test' module:
> > >
> > > $ sudo ndctl disable-region all
> > > disabled 8 regions
> > >
> > > $ sudo modprobe -v -r nfit_test
> > > rmmod nfit_test
> > > rmmod nfit
> > >
> > > $ sudo modprobe -v nfit_test
> > > insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> > > insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
> > > modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or
> > unknown parameter (see dmesg)
> > >
> > > $ dmesg | tail
> > > [  919.861636] nfit_test: Unknown symbol acpi_nfit_test (err -2)
> >
> > I'm still not sure how you are managing to hit "unknown symbol"
> > errors, are you re-running depmod after creating the test modules?
>
> The above error:
>    "nfit_test: Unknown symbol acpi_nfit_test (err -2)"
> I have hit after having removed the 'nfit_test' module:
>    $ sudo modprobe -v -r nfit_test
> and having tried to reinsert it:
>
> $ sudo modprobe -v nfit_test
> insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
> modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or unknown parameter (see dmesg)
>
> because 'modprobe' has inserted the production version of the 'nfit' driver (kernel/drivers/acpi/nfit/nfit.ko.xz)
> instead of the test one (extra/nfit.ko.xz).

Right, that's broken, but I'm not sure why.

>
> Regarding 'depmod' I have run the following commands to build and install the kernel and the modules:
> $ make
> $ make M=tools/testing/nvdimm
> $ sudo make M=tools/testing/nvdimm  modules_install     # ---> it runs depmod
> $ sudo make modules_install     # ---> it runs depmod
> $ sudo make install

What distro? On Fedora rawhide I'm doing the same steps and end up with:

# cat /lib/modules/$(uname -r)/modules.dep | grep nfit_test.ko
extra/test/nfit_test.ko: extra/dax_pmem.ko extra/dax_pmem_core.ko
extra/device_dax.ko extra/nd_pmem.ko extra/nd_btt.ko extra/nfit.ko
extra/libnvdimm.ko
kernel/security/keys/encrypted-keys/encrypted-keys.ko
kernel/security/keys/trusted-keys/trusted.ko
extra/test/nfit_test_iomap.ko kernel/drivers/char/tpm/tpm.ko

...i.e. the test version "extra/nfit.ko" in the dependency chain.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
