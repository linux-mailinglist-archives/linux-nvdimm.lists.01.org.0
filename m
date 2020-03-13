Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C03184AE3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Mar 2020 16:41:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C212510FC3881;
	Fri, 13 Mar 2020 08:42:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 19AB110FC3593
	for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 08:42:29 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id j14so10566830otq.3
        for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYlJTH2qA+/4DS7qpZloj8tQt2V5eWoCXB8gjCwZ2kc=;
        b=h9DQVYhYvQlcSyfImi53yYMU+O7Ol/wR+jtSYqOd2BSfTArxkJ7C0VM23mqbxyPzbm
         V7kAmXRFsP3ChuCy60lApQc4f+RhN3vUFAGXvjPszt7TrWshRv0js69TIdAGQEj8P7WW
         wZtItoT9BEIxk3CerPZ3v/lw2ylShpwCouJJCm9bPseawuLetrFJxvswcGJ/qSsJU50B
         lxsklW9UVDXLnUPnMyBrWQmA26vqj6W/hqqRewo2B1PI+VQ6N0Tt+NLxZNpUz87QgPTP
         b9Xm3rDqEWGCgiiht3tFjolMcS/sdwpnlZ/pOlmfDXt9mb6weuC89Nl1jMhSXU6FFsJK
         G3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYlJTH2qA+/4DS7qpZloj8tQt2V5eWoCXB8gjCwZ2kc=;
        b=NueXEcW/bmnHAePQfsgxsJliQZ/EZXUlSyOhs1ZrOIZ5kVWdqb5J+cykwiIoL6okZd
         rIfYTQ0FyCpIwj7haOnzIzBaaKfBcveZ0bpiw1o2cNQV+/uWcZuos1EY82NutaUWdE2z
         Za/vbMCVEFK7pVp+brx+Li1ouh1Dn6OFZRWDPTuZEJ8t+PbkkI0nOPvJbtn5Jp3WBI1E
         BY83qfKIJtovWSMHTzqYw/tvszkfxvJZflpSPbkn3obtKQfog/XVhM2e0C/KBWVzE6/h
         lDG+H8DjmcJleUMv9spnHBkTRiS/MqXHoqYJyPSK3p6kmaFfc3CTBjWhDqf1oaMd+5+o
         4PeA==
X-Gm-Message-State: ANhLgQ118IWQfdljpqmQT2qus20JxaNqHJxPV2luWP5n2DInBYY81YgU
	rthZzGkSeEUpGZEjt+LUqHYUPoLZiXpBDbd6M51BQg==
X-Google-Smtp-Source: ADFU+vu4dTjfsE9awiFQZ7RTA8r1tCDcA0vOmyeGowfNEuM5ChlrpYd3gvqQYxDdF83y4nm1f7cGIwobrgpN3qwvPYk=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr11049761otq.247.1584114097473;
 Fri, 13 Mar 2020 08:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <SN6PR11MB2864B07E6EA3CFCDB77169FE96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4hX5D6G6uSCoeV78NfJtNj8cvk5=ouLJ+EL2SXvqi-d_Q@mail.gmail.com> <SN6PR11MB28647C6C4DE888D1B74A903B96FA0@SN6PR11MB2864.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB28647C6C4DE888D1B74A903B96FA0@SN6PR11MB2864.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Mar 2020 08:41:26 -0700
Message-ID: <CAPcyv4igs_41gvtoqkA6a8LshkrXsKLBaZa3KwkuRRPyczdXSg@mail.gmail.com>
Subject: Re: nfit_test: issue #2: modprobe: ERROR: could not insert
 'nfit_test': Unknown symbol in module, or unknown parameter
To: "Dorau, Lukasz" <lukasz.dorau@intel.com>
Message-ID-Hash: MTKGHRIZCXVXEZZMHFITO7FHNGUGSKLI
X-Message-ID-Hash: MTKGHRIZCXVXEZZMHFITO7FHNGUGSKLI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Slusarz, Marcin" <marcin.slusarz@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MTKGHRIZCXVXEZZMHFITO7FHNGUGSKLI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 13, 2020 at 2:49 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
>
> On Thursday, March 12, 2020 6:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Yes, you're environment is not being careful to exclude the production
> > version of the modules from being loaded. The ndctl unit test core
> > also sanity checks nfit_Test and reports the collisions before running
> > tests. See nfit_test_init():
> >
> >     https://github.com/pmem/ndctl/blob/master/test/core.c#L119
> >
> > I'd recommend at least running:
> >
> >     make TESTS=libndctl check
> >
> > ...from latest ndctl.git to sanity check your nfit_test module
> > dependencies before trying to load it manually.
> >
> > See the troubleshooting document:
> >
> >     https://github.com/pmem/ndctl#troubleshooting
> >
> > ...for other tips about how to prevent the production modules from loading.
>
> Thanks for tips! I have followed those instructions and it did not help:
>
> $ cat /etc/depmod.d/nvdimm-extra
> override nfit * extra
> override device_dax * extra
> override dax_pmem * extra
> override dax_pmem_core * extra
> override dax_pmem_compat * extra
> override libnvdimm * extra
> override nd_blk * extra
> override nd_btt * extra
> override nd_e820 * extra
> override nd_pmem * extra
>
> $ find /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/ -name "*nfit*"
> /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit
> /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nfit.ko.xz
> /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
> /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test_iomap.ko.xz
>
> $ make TESTS=libndctl check
> [...]
> make --no-print-directory check-TESTS
> SKIP: libndctl
> ============================================================================
> Testsuite summary for ndctl 67
> ============================================================================
> # TOTAL: 1
> # PASS:  0
> # SKIP:  1
> # XFAIL: 0
> # FAIL:  0
> # XPASS: 0
> # ERROR: 0
> ============================================================================
>
> $ cat test/test-suite.log
> [...]
> .. contents:: :depth: 2
>
> SKIP: libndctl
> ==============
>
> test/init: nfit_test_init: nfit.ko: appears to be production version: /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> __ndctl_test_skip: explicit skip test_libndctl:2695
> nfit_test unavailable skipping tests
> libdaxctl: daxctl_unref: context 0xe02a00 released
> libndctl: ndctl_unref: context 0xe05f20 released
> attempted: 1 skipped: 1
> SKIP libndctl (exit status: 77)
>
> As you can see 'ndctl' also cannot load the extra test version of the modules even if there is the following file:
>
> $ cat /etc/depmod.d/nvdimm-extra
> override nfit * extra
> override device_dax * extra
> override dax_pmem * extra
> override dax_pmem_core * extra
> override dax_pmem_compat * extra
> override libnvdimm * extra
> override nd_blk * extra
> override nd_btt * extra
> override nd_e820 * extra
> override nd_pmem * extra
>
> Can I try anything else? Do you have any suggestions?

Do you have the nfit, or libnvdimm modules loading from the initramfs?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
