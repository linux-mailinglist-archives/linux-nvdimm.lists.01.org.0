Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A2F229A00
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jul 2020 16:25:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BF88B12491C5F;
	Wed, 22 Jul 2020 07:25:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com; envelope-from=htt.www.riaoffice@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4E30912491C5F
	for <linux-nvdimm@lists.01.org>; Wed, 22 Jul 2020 07:24:58 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so2756167ion.0
        for <linux-nvdimm@lists.01.org>; Wed, 22 Jul 2020 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=8zWyvxKfZ4TxLN9sTT3bJnsAx5TXhnWWojMI5XsquPU=;
        b=XBZXrWdYrfLvdpKIOomgu1XMxlCmipymHIQUuLbKHzrgENsVCVlAtLgYMLr1CHObSK
         HQKhc+2V2ydDvFMLcLvvO7eLym5sfjqAFxGRKvOYJU7NTz2svLC3GdBmWeluR6MmygRo
         QeC6s9/P+bgnAsJFCx5q62V7XkKailWu8XGjs3nLnz9a5tNOZZs21dEsOQwS5rVXzbi/
         mhiUu8VmHXgGMC56FtttQDfDnLLUrpOV8JFv9VcKQ3nm8ZZwodFQzBaO0fZmp8ZaMxDz
         KI9fEL2MHVFafNgLvEMA1LU0IBpox2g2XKY7TKMw9qmx1vCCClwcuCPV6K/g9r0+LfB/
         3Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=8zWyvxKfZ4TxLN9sTT3bJnsAx5TXhnWWojMI5XsquPU=;
        b=j1jq/gTLoydTZF/a+kGXiYt4+z4DrWmEnPX6y/J9BMfeEUCFFbs4Nw5u3lfleJO0Eg
         Mk86T2MZ40zJwSQ3Q36DmLvPFAufJz70TfscmeZFD99+kWa4IuV1aN6vIXUcjsfFDF+i
         JF/RXp7GkjSL/6ceYlKPPXgE/SWUQAlGSAqBbMcJ42mInF6WE0NuRsFsoqNZnazErTxz
         7qp2i6DnAdY2BbDG2zedWNJ8IsSlheuAI6kDnCVeo8TG0wfcMAHbeaqQlPpa32RszrBM
         PF0OItLmOWDtHnh/tdGE5Li59NbmngVzZUTOFJIyw7Y0eOTV0bDOEUFvyzKinUl5mn3N
         5SVw==
X-Gm-Message-State: AOAM532k3vLSFQIvTV82T8huQxawc5ObMExz+Ef/1AtHKFzYynZ8GRmx
	sYyUuNWApNnZ2u1kn9DQ28nYJYUdwQt5KrgFbDY=
X-Google-Smtp-Source: ABdhPJxPAH/N5//zUDS8u124MwWz3nZFyWMuIm101wifnHi13iO7PEtbRu50lOan3JVPhdeI4hPXTv73eRwDAbzaUXM=
X-Received: by 2002:a02:c903:: with SMTP id t3mr37349793jao.30.1595427897165;
 Wed, 22 Jul 2020 07:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAEd4W985QAMzEcYsXHZWcnpqW96iZ8Djh1aXYsLKsZhZ5-BjXA@mail.gmail.com>
In-Reply-To: <CAEd4W985QAMzEcYsXHZWcnpqW96iZ8Djh1aXYsLKsZhZ5-BjXA@mail.gmail.com>
From: NGENE NKANI <htt.www.riaoffice@gmail.com>
Date: Wed, 22 Jul 2020 14:24:38 -0700
Message-ID: <CAEd4W9-ehkYJ1TGFmvkUdY6Lf7C_ZmVENm9fPxFjJHMnskSCZg@mail.gmail.com>
Subject: 10
To: undisclosed-recipients:;
Message-ID-Hash: V3TUHJIHUFQAD7ZVKDPEQWNYZRUN5UPQ
X-Message-ID-Hash: V3TUHJIHUFQAD7ZVKDPEQWNYZRUN5UPQ
X-MailFrom: htt.www.riaoffice@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: ngenenkani.org@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V3TUHJIHUFQAD7ZVKDPEQWNYZRUN5UPQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
