Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0AB1889F7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Mar 2020 17:14:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AEEAE10FC3411;
	Tue, 17 Mar 2020 09:15:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E355E10FC340F
	for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 09:15:32 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w13so22374702oih.4
        for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wsVK7LS17ZG2RWKPVHSfzoC8LEQ7vj/hUyu1cWEg+Pg=;
        b=OCA5Yw4rLe92CXCBvEJbstgJAwSNQ5YYSu0MkbOGidYye8odMRrhmKdO36Mv9ZitzI
         pL+8DCorCJrAjOt5xK5xcDUwRRBLdUKm1T4c5DS4RoovJyFil60XvfBcH5C0zqA+73kk
         A608/NBRam1ly1VmVu2tTOj74TLkL5A4wc30cfq3cGkojLVOWBXPByNt9lVU7zSwTjO1
         mRPIJwQOJCoxqCRPVBIzkWLf3/9JsLyf21KTUe6UVUJlApvYeDH3tUBDmpE8Ulhe9mR+
         hM7FFxZ5FvRp9+6eYMxz49NFEuOJY+ECYOBMNKvYBMdSPyenIq4OIKz0WOS37gAioQDw
         anjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wsVK7LS17ZG2RWKPVHSfzoC8LEQ7vj/hUyu1cWEg+Pg=;
        b=ulEoXngtfQ/xfLw25V8xtWaVchqltlNUPnAW4bhZc2ypRvf9a6hhjD+BWjPbVsJ566
         np3qVUb4i5Etb7U+3e2t+sjd5fdAjGc0F9y3FStmyDIiMXyAg8nRqq1lnknWw//BuBHs
         upXQ/6JgxG2ynAw0Y91ZiFy4jtmBtMz3co+tNIzGyeFcu2ztNzXCqdD+y/SjOtttZ9xZ
         Ct9vLcw+NnBz+wHJ+9UaYRPjDFK6wpzR7/H6LbigJr9eW4enG3oxBljBaX+DUKEJV7oY
         BOklROmPjVsUxDQ8z2jK9sQyJMhKp01ukFQxV392truN6Ub42HiydpGzzTk9DDpVTdJI
         fYyA==
X-Gm-Message-State: ANhLgQ2H/et1pDTgHBgwUlDuOijLkJSsEu2L3DK6TTuGnngdg+oRoHQM
	912JhWvuHAck8RDEESrrDu11q6eGZrsIwRGJd6VdQg==
X-Google-Smtp-Source: ADFU+vsDbYdu5fIoQMNfuCUwF9tVMdIhMer7QiDZDSBVjMKUFyZXnF0DUs81xLGt8tipcGGAISppdHyTZmZhPJMH3To=
X-Received: by 2002:a05:6808:90f:: with SMTP id w15mr103661oih.0.1584461680430;
 Tue, 17 Mar 2020 09:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <SN6PR11MB28641D4A1AF433086764A98D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <SN6PR11MB2864BBFAA6EC62A7747F9E5D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4gXZKPyqu+9JmWuivw4Yuc05_Q+bbcjRAsHK2PWKtjwjg@mail.gmail.com>
 <SN6PR11MB286493B9A749705B8A107F4396FA0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4jOuTXdNzUTSj2EWBoKJ5V8FeEWo4cCA3e95jdT3=7XFQ@mail.gmail.com>
 <SN6PR11MB28647B2D8B3C0729FE0CCDD696F90@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4iAJbZpKYzA5SgGcH+dkPQyHkxgGgufTd_YnSZ5bF_X7A@mail.gmail.com> <SN6PR11MB286403BE843E5B13813825E396F60@SN6PR11MB2864.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB286403BE843E5B13813825E396F60@SN6PR11MB2864.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 17 Mar 2020 09:14:30 -0700
Message-ID: <CAPcyv4hTGGeesNtoEsjaqibhPFihpwUpEXjOaQZrD86YUxfjMw@mail.gmail.com>
Subject: Re: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
To: "Dorau, Lukasz" <lukasz.dorau@intel.com>
Message-ID-Hash: KMYBRFBPKPQVTRFPEXZ6BFKKSU76ZFBY
X-Message-ID-Hash: KMYBRFBPKPQVTRFPEXZ6BFKKSU76ZFBY
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KMYBRFBPKPQVTRFPEXZ6BFKKSU76ZFBY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 17, 2020 at 2:09 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
>
> On Tuesday, March 17, 2020 9:26 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > On Mon, Mar 16, 2020 at 1:58 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
> > > The above error:
> > >    "nfit_test: Unknown symbol acpi_nfit_test (err -2)"
> > > I have hit after having removed the 'nfit_test' module:
> > >    $ sudo modprobe -v -r nfit_test
> > > and having tried to reinsert it:
> > >
> > > $ sudo modprobe -v nfit_test
> > > insmod /lib/modules/5.6.0-rc1-13504-
> > g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> > > insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
> > > modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or
> > unknown parameter (see dmesg)
> > >
> > > because 'modprobe' has inserted the production version of the 'nfit' driver
> > (kernel/drivers/acpi/nfit/nfit.ko.xz)
> > > instead of the test one (extra/nfit.ko.xz).
> >
> > Right, that's broken, but I'm not sure why.
> >
> > >
> > > Regarding 'depmod' I have run the following commands to build and install the
> > kernel and the modules:
> > > $ make
> > > $ make M=tools/testing/nvdimm
> > > $ sudo make M=tools/testing/nvdimm  modules_install     # ---> it runs depmod
> > > $ sudo make modules_install     # ---> it runs depmod
> > > $ sudo make install
> >
> > What distro? On Fedora rawhide I'm doing the same steps and end up with:
>
> Fedora release 31 (Thirty One)
>
> >
> > # cat /lib/modules/$(uname -r)/modules.dep | grep nfit_test.ko
> > extra/test/nfit_test.ko: extra/dax_pmem.ko extra/dax_pmem_core.ko
> > extra/device_dax.ko extra/nd_pmem.ko extra/nd_btt.ko extra/nfit.ko
> > extra/libnvdimm.ko
> > kernel/security/keys/encrypted-keys/encrypted-keys.ko
> > kernel/security/keys/trusted-keys/trusted.ko
> > extra/test/nfit_test_iomap.ko kernel/drivers/char/tpm/tpm.ko
> >
> > ...i.e. the test version "extra/nfit.ko" in the dependency chain.
>
> On Fedora release 31 (Thirty One) I have the production version ("kernel/drivers/acpi/nfit/nfit.ko.xz") in the dependency chain:
>
> $ cat /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/modules.dep | grep nfit_test.ko
> extra/test/nfit_test.ko.xz: extra/test/nfit_test_iomap.ko.xz kernel/drivers/acpi/nfit/nfit.ko.xz kernel/drivers/nvdimm/libnvdimm.ko.xz kernel/security/keys/encrypted-keys/encrypted-keys.ko.xz kernel/security/keys/trusted-keys/trusted.ko.xz kernel/drivers/char/tpm/tpm.ko.xz kernel/drivers/char/hw_random/rng-core.ko.xz
>
> I do not want to use Fedora rawhide, because AFAIK ndctl does not compile on it.
> All I need now is to know the distro & kernel the 'nfit_test' module works well with.
> Do you know them?

Yes, any Fedora should be fine. When I say I'm using Rawhide I've used
it for years and have not hit this issue which means I used it when
Rawhide was equivalent to Fedora 31. Try running the module install
sequence a second time. The first time through it establishes the
dependencies of test modules on production, but I think it needs the
test modules already installed to resolve dependencies the other
direction. The other thing that might be contributing to broken
dependencies is that you seem to have CONFIG_LOCALVERSION_AUTO
enabled. The effect is that any change to the kernel tree will result
in a brand new module directory and exacerbate the dependency problem.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
