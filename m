Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23AB2AAFAC
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Nov 2020 04:01:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4117165FB3E4;
	Sun,  8 Nov 2020 19:01:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 61277165FB3E2
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 19:01:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id o21so10141667ejb.3
        for <linux-nvdimm@lists.01.org>; Sun, 08 Nov 2020 19:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hgu/k4zI/PAPcWBWO9vf1j0+fK94QC+FCf314+RmfbY=;
        b=sPhZ9whnk5VGdJCG9lq6Bz+Onj9yik5TGjS/BO/nCCTO10lVJvqunxCLkeCFuObFBF
         EfwrDREbh42sbnNvNWfcbfse0g1TaM0L5Um6bjjnqlrPrMB1FREbV9If5S5PqqAA1pjE
         CfhtYuDDSpMPRYcMXfM7twGI/Lq5sBYqlFrsDE87nF9AUDbge64T0stSbyjF6ZBmboP5
         y8Z/NLgnDsa6VA0MawNzuWMH/MW5bpD/1ux/ub1OtWFZcwNl3V4UApvD2figbv9Cf/Sb
         iw3fxkCXncBdSb1kzQcT/H9veKLfCY4X9pvbtAxKv2EHJTusdsptxLPRKUMssAmXih0O
         DTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hgu/k4zI/PAPcWBWO9vf1j0+fK94QC+FCf314+RmfbY=;
        b=VaO/bCtbSbFpRloAFqnjL799kgUvS5gbbdIa0BU2Cz+IAuHiJ7Yk+6cdbHARnv5S3J
         gkOvzIxHYYY38PCymzTukQFO57KzlVeGkCJmaHrlw0AZERHi2+d4vvZ0nNyE/lzI2QIG
         ioDRLD1M0gK0K14Wgxt4pUYaTfuOrpyF/gPMi2wa3w3zc5vz0uja4vA3gx7L938aFYkH
         kkOkXVXQeUF/HIxmafNDiZwdE8omc/X8ADG5GJf0MUTuND1BA+ZrVW/IbfxDL5t8MRh6
         yzfQXgoD8pZCA0CH0YLXl33bfvrfJ/7MNtrGMAmDPsJg3UZHrsjHdn0m5dAWMMCnNhnw
         sH3g==
X-Gm-Message-State: AOAM531DA79TNPwr0g3OQsVDo6X7m3S0QWE/gZ/l2OJusyY6/AsJtmXL
	zt0Moo57fvJkoOAy5xqAYYVFrKioiixOrA02xmxO2g==
X-Google-Smtp-Source: ABdhPJzogCBPEJxw3FL8TpXkAzXDhgiSH6XRoKH6IHll9g1LqC0+ZZd2V+SlZNiyc6//kt3VRnk5Oo14KrT8AylHfyg=
X-Received: by 2002:a17:906:ad8e:: with SMTP id la14mr12395099ejb.264.1604890869322;
 Sun, 08 Nov 2020 19:01:09 -0800 (PST)
MIME-Version: 1.0
References: <1934921834.1085815.1604889035798.JavaMail.zimbra@redhat.com> <1687234809.1086398.1604889506963.JavaMail.zimbra@redhat.com>
In-Reply-To: <1687234809.1086398.1604889506963.JavaMail.zimbra@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 8 Nov 2020 19:00:58 -0800
Message-ID: <CAPcyv4jto-LCR6EUZj0bka8De9NTwB5OkYLbK83O5hubGfknPQ@mail.gmail.com>
Subject: Re: regression from 5.10.0-rc3: BUG: Bad page state in process
 kworker/41:0 pfn:891066 during fio on devdax
To: Yi Zhang <yi.zhang@redhat.com>
Message-ID-Hash: XSVYXBIXVRNNMUN7W3L3TROJ6GHNSZ5H
X-Message-ID-Hash: XSVYXBIXVRNNMUN7W3L3TROJ6GHNSZ5H
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XSVYXBIXVRNNMUN7W3L3TROJ6GHNSZ5H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 8, 2020 at 6:38 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> I found this regression during devdax fio test on 5.10.0-rc3, could anyone help check it, thanks.

Have you been able to bisect it?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
