Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC9E3732F8
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 May 2021 02:12:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62A77100EBBC0;
	Tue,  4 May 2021 17:12:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BEF3E100ED4A0
	for <linux-nvdimm@lists.01.org>; Tue,  4 May 2021 17:12:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y7so114896ejj.9
        for <linux-nvdimm@lists.01.org>; Tue, 04 May 2021 17:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrhPGvHlIr/7Xl07KopUpg5Wy5+M8jpP25va8IasNzg=;
        b=ys+mX2vjpVaHSm7uh4IF90K03qF8UO6+a+0ebX5KU1ZijOGMP4kfzLs1RFCxZyrgsP
         PnvWNqYQApCNMTQy31WzhCPH7jUamZ/bGcwJrJUnfMQY3wLMt/+S6T88WJDDOHfWfpo6
         EVfI3XUkaiUSsMd4pJ9dS5/ddHvJFAfAXnJpaB7W9UppuibzBN862gncviGxGSw32K6l
         PTCdTreJnYdWHAJIB4HVUchsIz4d2D72WXAMySFB4+I8cOve8BVey0bLrVThPx7LIoaK
         5mWvy3Dzl+FSUCPmf+vHyOiSicq+flEw6O+TRYIsfOJQYwIkdLQJlLIWsndp5KRNzg/P
         WBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrhPGvHlIr/7Xl07KopUpg5Wy5+M8jpP25va8IasNzg=;
        b=gzx5bU8OYaD8t1jkKEzgj33q12i67bSxk/hMQJ/2WJy+vl1DqI50q/zDS12PmlKih+
         lBYb7kg09M5lECxt19o0kpURZuVZEcyNf10Qg7fI//wifOyQ60++hfjuUjX9Ro/KdcKI
         wd460Qzhy3RNtTjwWZ8ImMRS1TkxD9uJm/0ciXzkpBHkH223RK00lAcCxzyg2lBk/3Ey
         /TgMewtn4lrPnioDCQn6wxRcsP5O3swqAjVaEgVp811cxSYuuyoOfSVyEvx4slY53SUM
         zVx/VUGfQ65MJTRPkkkH7IKqUDH4OZ0+pt+7T7ex7IP8NsWJt9KK473gVU9TIU56htM/
         /bPA==
X-Gm-Message-State: AOAM532vd0PaJ6eY5jBjoz/hwplv1CNCGaG4FKWL8HHctEFVw/50YUku
	5Ee/034vBBNvF3DwGgItuPwNhZK5fH2sqZlPP0zD6g==
X-Google-Smtp-Source: ABdhPJzbcZp8fgji7EBWOpiIEfEVjWfOuXNO53F1TLCgNI9zX3VJkgmXm7g3xjmN0SZVleyyejvSiS6aZECF7977N9M=
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr24797391ejy.323.1620173537351;
 Tue, 04 May 2021 17:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <CAPcyv4gwkyDBG7EZOth-kcZR8Fb+RgGXY=Y9vbuHXAz3PAnLVw@mail.gmail.com>
 <bca3512d-5437-e8e6-68ae-0c9b887115f9@linux.ibm.com> <CAPcyv4hAOC89JOXr-ZCps=n8gEKD5W0jmGU1Enfo8ECVMf3veQ@mail.gmail.com>
 <d21fcac6-6a54-35fd-3088-6c56b85fbf25@linux.ibm.com> <CAM9Jb+g8bKF0Z7za4sZpc2tZ01Sp4c4FEaV65He8w1+QOL3_yw@mail.gmail.com>
 <023e584a-6110-4d17-7fec-ca715226f869@linux.ibm.com>
In-Reply-To: <023e584a-6110-4d17-7fec-ca715226f869@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 4 May 2021 17:12:19 -0700
Message-ID: <CAPcyv4hEhZoma=t=EtDXGr9r-i5K0GP01NU=jyDOmdp1YHn2rw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: ZDUMXRL44NRKFICT4D7VOVWZRDK2JRTU
X-Message-ID-Hash: ZDUMXRL44NRKFICT4D7VOVWZRDK2JRTU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZDUMXRL44NRKFICT4D7VOVWZRDK2JRTU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 4, 2021 at 2:03 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 5/4/21 11:13 AM, Pankaj Gupta wrote:
> ....
>
> >>
> >> What this patch series did was to express that property via a device
> >> tree node and guest driver enables a hypercall based flush mechanism to
> >> ensure persistence.
> >
> > Would VIRTIO (entirely asynchronous, no trap at host side) based
> > mechanism is better
> > than hyper-call based? Registering memory can be done any way. We
> > implemented virtio-pmem
> > flush mechanisms with below considerations:
> >
> > - Proper semantic for guest flush requests.
> > - Efficient mechanism for performance pov.
> >
>
> sure, virio-pmem can be used as an alternative.
>
> > I am just asking myself if we have platform agnostic mechanism already
> > there, maybe
> > we can extend it to suit our needs? Maybe I am missing some points here.
> >
>
> What is being attempted in this series is to indicate to the guest OS
> that the backing device/file used for emulated nvdimm device cannot
> guarantee the persistence via cpu cache flush instructions.

Right, the detail I am arguing is that it should be a device
description, not a backend file property. In other words this proposal
is advocating this:

-object memory-backend-file,id=mem1,share,sync-dax=$sync-dax,mem-path=$path
-device nvdimm,memdev=mem1

...and I am advocating for reusing or duplicating the virtio-pmem
model like this:

-object memory-backend-file,id=mem1,share,mem-path=$path
-device spapr-hcall,memdev=mem1

...because the interface to the guest is the device, not the
memory-backend-file.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
