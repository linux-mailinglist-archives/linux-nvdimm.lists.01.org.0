Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFEB2D1E53
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 00:26:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D65C5100EB820;
	Mon,  7 Dec 2020 15:26:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB102100EBB9F
	for <linux-nvdimm@lists.01.org>; Mon,  7 Dec 2020 15:26:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jx16so21952651ejb.10
        for <linux-nvdimm@lists.01.org>; Mon, 07 Dec 2020 15:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeYYKT8U9PiMegGOS4dFHtakY9RdfiONuxXT42iXGLQ=;
        b=YJ+byRv8O/FZx2vP+Qrg9qk9YUtKFNKi5yZeKR0ok8KgU5gyDYqUau8CFz/Tj+buaq
         I69Ri+vEjCIoOnMkQI3/s53+ARfn2AkQM/W4kvOo4Xwi02GLaW41UTbRb+90QlItlHBi
         fx187Qc7cazXk/wasgu5xTKiszut2dIeBawS1e85heG4tssZpddiIArkI6K0f4n5cycC
         LZjbPTH+i22H/0Be2QsG5RuHSy2FLrFs/RVvo62RYW9DLZ026O69BlsOAB0i9bCtfcwu
         b68jzbLvU6mLud3Pwc+/iMNmt2WZ9kM2HmJFEQV1y1ze+37ucJzQBHWlURwOQ9KzVXHv
         lm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeYYKT8U9PiMegGOS4dFHtakY9RdfiONuxXT42iXGLQ=;
        b=n8WMZD9BExEZQYrnntbzMRo4z1a2r5HiQUHqOrFA0X5o8k9iGYdjdOjzEL2tpKLaum
         UIOjcynJZIZr7D8I9Q5S7WbRPSbRJ8STH7W+Tat9FvcTAXTmMiE7QiHsDbNroBEi3ZFE
         owqC93cgD1KEOqrP0m/vBbEMmQI+Lkqgb+1Z/mpwENMmg4BxXatUIO0ahv8oLCaZ/hjO
         5Nua1nopn9RRfavkeNNd8rPYkpTganWno2nbne+xVapyJfNTxuWonChAgnfnU5VpUuih
         obdI1hoZACLSoXGrlsvmUj+41ptZ/5InfcZ5pk/8bqk30hh4mWpeDBUYwz/cekfqdABo
         rJxA==
X-Gm-Message-State: AOAM532XKn3kCVBlVwqER8aSPnJ8N7iNYUbvTUMHgVIxQ9bF5c1VJEud
	W3heVxBH+1v1X2EtCmg+dAWoBkyKj6eTXE92r1ABeQ==
X-Google-Smtp-Source: ABdhPJyIgxo5TpAKf2OkRIR1eZgMiPKErbpShdYwwafawh5xDDQ3PkrXbT+LD3laL1kqQZRVXcnCVyKNQiyXfZwrBJ4=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr15534981ejc.418.1607383562335;
 Mon, 07 Dec 2020 15:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20201108121723.2089939-1-santosh@fossix.org> <20201108122016.2090891-1-santosh@fossix.org>
 <20201108122016.2090891-3-santosh@fossix.org>
In-Reply-To: <20201108122016.2090891-3-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 Dec 2020 15:26:00 -0800
Message-ID: <CAPcyv4jdTwOztdaAJ68coQBfbm_meX6L0Ua-6Gzu-15eZeEQ9A@mail.gmail.com>
Subject: Re: [ndctl RFC v4 3/3] Use page size as alignment value
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: M6PCBASVUQAVUH7DK43VQYIK2SMPTCH2
X-Message-ID-Hash: M6PCBASVUQAVUH7DK43VQYIK2SMPTCH2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M6PCBASVUQAVUH7DK43VQYIK2SMPTCH2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 8, 2020 at 4:21 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>

-ENOCOMMITMESSAGE

...I can guess why this is needed, but I'd rather not guess.

Otherwise, looks ok to me.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
