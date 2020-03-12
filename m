Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1761836DC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Mar 2020 18:06:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71E8D10FC378B;
	Thu, 12 Mar 2020 10:06:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5F7410FC3404
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 10:06:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id y71so6208818oia.7
        for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnUkLOUxFaPb8VlyluT+u//UshqW0eFIi+oknlNcnhg=;
        b=WXeum+s+2ha6lmQecRZ5P6T/0pxET8TM1jAdxsYIwp+YuQ7tORK5nIUCQL1NLbl29p
         iRLJ9WsQep/k0HSkessCfawOi4heSlpb6XaEPPY/PtPlMEQPAMY9dLM9ZJetZgdNRQLS
         jFD/LYRyHBuDo7v4J47Z4Ccr5P1Bp29kfoR5AcCVsK8JdtTppWmHYQUVzC/48wgE84UU
         F309GACwu9iU4+CNrmBCyj4rn194hvQNEOlKMWYJN0LZqq2Nn8A2Dv9WKcHFlL7YMEHe
         sGdgpg5UBa8iwdq5MfkUoVuCNXwxEr7HQT2KamJqmq3v2Wz8kUnWnZHo3aNHKAKyi25H
         rg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnUkLOUxFaPb8VlyluT+u//UshqW0eFIi+oknlNcnhg=;
        b=jAGOfzCkHkJ3KF66tH0pRU2IfGWnLZkfCb9v7WkRYLTZpgU1JRLNB3ivGc03P2V74P
         lOVbortG7+wcy0vBfp5oGjDONz8YLDaIbTEUM1GQhBu/YdklG4ZLl+HnuZScPekrvUWm
         bECgfcEx/yEKRTrgBGcj7VTZ+4JyW5XR4EZZmd3lZ9ap2HJrVNZW+YIQ1JWdu9wx80LP
         2VzQtzbotqjZWXIllX3f20MjmiSkSXerOh7yGdOUZ9DTVXL3i4F5c2XG7GiijCCmiwD/
         bXfi4F3qZk/iIx1MM1dGlRhp7nw9g9LtKhZn8jrBcdMO+BXr9aLEbV5sTS42ywxkhOUt
         6/7Q==
X-Gm-Message-State: ANhLgQ2I6zg0V4bmte/qBxHE166EPF64cYtet7fFdWOihjsRQexBCZwL
	MsV/JV/kZimVaLxzgUoEsA1YJBRcpC1+DLtnit4ITA==
X-Google-Smtp-Source: ADFU+vuc+WaloYEJ+6c4v7wWfAnFUUUPxtB2IW6ySbzxZ+vsPh6Tb0mSebrz3L7O6hHzllDwFIg653t+t7SLrkfowDU=
X-Received: by 2002:aca:4d8:: with SMTP id 207mr3239018oie.70.1584032764652;
 Thu, 12 Mar 2020 10:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <SN6PR11MB2864B07E6EA3CFCDB77169FE96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB2864B07E6EA3CFCDB77169FE96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Mar 2020 10:05:53 -0700
Message-ID: <CAPcyv4hX5D6G6uSCoeV78NfJtNj8cvk5=ouLJ+EL2SXvqi-d_Q@mail.gmail.com>
Subject: Re: nfit_test: issue #2: modprobe: ERROR: could not insert
 'nfit_test': Unknown symbol in module, or unknown parameter
To: "Dorau, Lukasz" <lukasz.dorau@intel.com>
Message-ID-Hash: X47VKK5IHOGZWJ6464UJQSYNFCABYLLL
X-Message-ID-Hash: X47VKK5IHOGZWJ6464UJQSYNFCABYLLL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Slusarz, Marcin" <marcin.slusarz@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X47VKK5IHOGZWJ6464UJQSYNFCABYLLL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 12, 2020 at 7:38 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
>
> Hi,
>
> Inserting the 'nfit_test' module in a natural way fails with the following error:
>
> $ sudo modprobe -v nfit_test
> insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/char/hw_random/rng-core.ko.xz
> insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/char/tpm/tpm.ko.xz
> insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/security/keys/trusted-keys/trusted.ko.xz
> insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/security/keys/encrypted-keys/encrypted-keys.ko.xz
> install /usr/bin/ndctl load-keys ; /sbin/modprobe --ignore-install libnvdimm $CMDLINE_OPTS
> No TPM handle discovered.
> failed to open file /etc/ndctl/keys/nvdimm-master.blob: No such file or directory
> insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/nvdimm/libnvdimm.ko.xz
> insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test_iomap.ko.xz
> insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
> modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or unknown parameter (see dmesg)

Yes, you're environment is not being careful to exclude the production
version of the modules from being loaded. The ndctl unit test core
also sanity checks nfit_Test and reports the collisions before running
tests. See nfit_test_init():

    https://github.com/pmem/ndctl/blob/master/test/core.c#L119

I'd recommend at least running:

    make TESTS=libndctl check

...from latest ndctl.git to sanity check your nfit_test module
dependencies before trying to load it manually.

See the troubleshooting document:

    https://github.com/pmem/ndctl#troubleshooting

...for other tips about how to prevent the production modules from loading.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
