Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFA312ADC0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Dec 2019 18:54:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E48C71011367A;
	Thu, 26 Dec 2019 09:58:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85C2F10113679
	for <linux-nvdimm@lists.01.org>; Thu, 26 Dec 2019 09:58:00 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 77so33208412oty.6
        for <linux-nvdimm@lists.01.org>; Thu, 26 Dec 2019 09:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPrgm5oYCoy7v1evEY+ndQWI3G9RXerzszLCz1oKpqU=;
        b=M/U+1ew67ka7NASbQx8Ps0LDgWbxk8wSmv9GQeZ9/1GpL2jB73fyzbUlFi5bC/reWR
         uLZmJmNdHQNSCgDollk+KCa/5MZE6suy2McIWE92Rv5wMlDEsZ3PM9t7pdgR9PuPFW6s
         w2nxQpFTxLDxGLZLkBhB9O81+0JzDFLEXpRvCVycgA7VsM/fXlTGpoLnPo0SNc8rEh1f
         BBbZZUXem7wH5U1r6Rd/IznDxiCfKCZdhMl5sH+S7D1SigeUqhtqhSpIOvD9ZLz0QkNV
         URX+/3dErxGscKZJejhDQKW9efCm3MK0hMCBWDRRhDWYMaRwHi0ErO3cxbYuD52Zks6T
         pWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPrgm5oYCoy7v1evEY+ndQWI3G9RXerzszLCz1oKpqU=;
        b=bHMKSxHAok+4Y/mS/+pJJ0n/HbziMAHHj0giKWJhocunuGU0o5gOZikLNTubYSNRWk
         oUq9neoVslym2zUJ2bJGmehInw+OfeSMzIoWao9QlPD3+ZPlEQKKvxLro7JKaBYqAwOC
         6vKYdfhUtAsHaiVcnj4iYm0/ABjhROuB3slPyo34AKU8qauXCEVCs+xNp0YAdEswljN1
         FCMRaDOw0OUGCZqW/JlbouHaXn1Lx/hhWQwhN+G/w9CWZ+RFXFnxznV9jJiyQnC8setf
         pRLtsDFJMg57BkIQpNx67PSgtnvQ+sGz6u6vIOHER4ukqU9q59bbOYOHQw7z0lpzkX6K
         ghnw==
X-Gm-Message-State: APjAAAXoVd5Y0XKqa6s0o9C2dX5wdOb3n1SQLoNmnGJQZKMIR163v9Uo
	WXFqEa7/EOMUG+22iyiylaw7iNxtfhY9cmcGfDrxp9yJkpI=
X-Google-Smtp-Source: APXvYqziLXhZhTDkqhZxsKVb/E69B/rlhNUTARig3ej3+79YBoh4C5TypBiB6gNnwCQydBqCdqbtQcrIkgTGyVLLY0c=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr44561341otm.247.1577382879751;
 Thu, 26 Dec 2019 09:54:39 -0800 (PST)
MIME-Version: 1.0
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
 <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
 <SN6PR11MB3264C140FEB5C66679095AFF922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB3264617D4EA3C3C4706C7C6D922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB32647968C27C92C1D3A5B7D8922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB32647968C27C92C1D3A5B7D8922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 26 Dec 2019 09:54:28 -0800
Message-ID: <CAPcyv4iU2xt9L1U7JXLoM1ex__KFHQ--6wdJeD2RNz6yfb87OQ@mail.gmail.com>
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.
To: "Li, Redhairer" <redhairer.li@intel.com>
Message-ID-Hash: 54GEPJBDDKV7TDRST4QKIVXQXJ5SCMBC
X-Message-ID-Hash: 54GEPJBDDKV7TDRST4QKIVXQXJ5SCMBC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/54GEPJBDDKV7TDRST4QKIVXQXJ5SCMBC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The way to fix this is mentioned in the log, see below...

On Wed, Dec 25, 2019 at 8:01 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> I saw daxctl-devices.sh is still failed before I apply my patch.
>
> root@ubuntu-red:~/git/ndctl# vi test/test-suite.log
> =========================================
>    ndctl 67.dirty: test/test-suite.log
> =========================================
>
> # TOTAL: 1
> # PASS:  0
> # SKIP:  0
> # XFAIL: 0
> # FAIL:  1
> # XPASS: 0
> # ERROR: 0
>
> .. contents:: :depth: 2
>
> FAIL: daxctl-devices.sh
> =======================
>
> + rc=77
> + . ./common
> ++ '[' -f ../ndctl/ndctl ']'
> ++ '[' -x ../ndctl/ndctl ']'
> ++ export NDCTL=../ndctl/ndctl
> ++ NDCTL=../ndctl/ndctl
> ++ '[' -f ../daxctl/daxctl ']'
> ++ '[' -x ../daxctl/daxctl ']'
> ++ export DAXCTL=../daxctl/daxctl
> ++ DAXCTL=../daxctl/daxctl
> ++ NFIT_TEST_BUS0=nfit_test.0
> ++ NFIT_TEST_BUS1=nfit_test.1
> ++ ACPI_BUS=ACPI.NFIT
> ++ E820_BUS=e820
> + trap 'cleanup $LINENO' ERR
> + find_testdev
> + local rc=77
> + modinfo kmem
> filename:       /lib/modules/5.4.0-rc5_red_ndctltest_VM/kernel/drivers/dax/kmem.ko
> alias:          dax:t0*
> license:        GPL v2
> author:         Intel Corporation
> srcversion:     A0712EA9D9E63723E6B4CDA
> depends:
> retpoline:      Y
> intree:         Y
> name:           kmem
> vermagic:       5.4.0-rc5_red_ndctltest_VM SMP mod_unload
> signat:         PKCS#7
> signer:
> sig_key:
> sig_hashalgo:   md4
> + testbus=ACPI.NFIT
> ++ ../ndctl/ndctl list -b ACPI.NFIT -Ni
> ++ jq -er '.[0].dev | .//""'
> + testdev=namespace0.0
> + [[ ! -n namespace0.0 ]]
> + printf 'Found victim dev: %s on bus: %s\n' namespace0.0 ACPI.NFIT
> Found victim dev: namespace0.0 on bus: ACPI.NFIT
> + setup_dev
> + test -n ACPI.NFIT
> + test -n namespace0.0
> + ../ndctl/ndctl destroy-namespace -f -b ACPI.NFIT namespace0.0
> destroyed 1 namespace
> ++ ../ndctl/ndctl create-namespace -b ACPI.NFIT -m devdax -fe namespace0.0 -s 256M
> ++ jq -er .dev
> + testdev=namespace0.0
> + test -n namespace0.0
> + rc=1
> + daxctl_test
> + local daxdev
> ++ daxctl_get_dev namespace0.0
> ++ ../ndctl/ndctl list -n namespace0.0 -X
> ++ jq -er '.[].daxregion.devices[0].chardev'
> + daxdev=dax0.0
> + test -n dax0.0
> + ../daxctl/daxctl reconfigure-device -N -m system-ram dax0.0
> libdaxctl: daxctl_dev_disable: dax0.0: error: device model is dax-class
> libdaxctl: daxctl_dev_disable: dax0.0: see man daxctl-migrate-device-model

If you run:

    daxctl migrate-device-model

...and reboot the test should start working. The explanation for why
this migrate-device-model step is needed is detailed in the man page.

    daxctl migrate-device-model --help
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
