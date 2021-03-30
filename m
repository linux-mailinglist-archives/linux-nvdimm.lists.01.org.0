Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DACB34E544
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Mar 2021 12:20:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8EB4E100EBB94;
	Tue, 30 Mar 2021 03:20:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com; envelope-from=vickyomenka@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 98571100ED49C
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 03:20:30 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w28so2007761lfn.2
        for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ULoUzB+Ud3ZGoN2ZQnI8hPejIIlsU/1fAlNzc2mCPvU=;
        b=oCtbC04aZlA2dzffhvrZ31VbbDMNAplujw+WFQqPTw08q3031ZirETqfEPOSkttHer
         vnca+8CweQjiO/bcXq6vs5I0LiKnyusz9LEaLcXHL3/jNIzwhdkbmQNWsjC6hU0AI+41
         tfN39YvXulp8nDF3Hoil7JLCR2P35/CYEa87w5aWKY9uhwPxK/Hivp3XdD6FO2xa3N1a
         C2Ow3wO2LthqFZFoPhfPBvVTYeTbvSiVU+DNUPSsdoY+DhyTmrBYZ3LyzEjoV6crZtGx
         Gqw+YjjcHUt0Nauu/qw19+nHJh8gzdsYros9tJV1Nn8SHCFvJdMPYL9hndqG3eUOrVcs
         TTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ULoUzB+Ud3ZGoN2ZQnI8hPejIIlsU/1fAlNzc2mCPvU=;
        b=ReDxzr0WmrYamHNnZ8LYc7JSXSUyCjROGr0Xb86PnGVJpLlBE5DF+O0NS3kq7tOA0f
         gg2R41NVsFuat5B3io9bBDnnPUyWBQgaKsje8sfklq8c4TlpA637btDjJpLy0ygg4D2n
         RT20ZvMV6u36F+VX/MMgZcD6RsDb7yggiTtUqIxbhrZOXxhPevLgkGqoulz2YQjQwQtO
         gAbVrY+xNxKe1aEh5LjbvSjXDUz28lujw6lPzVX6o47sAX2cmbzaIpBZjmk7Ivxbv02K
         erYHeoulZSDpA7Yu0+mVZznXUpXEg5pqCyOG+1V9HiD3i4w95s8//KBOGh3nNpgY1a4E
         h5/g==
X-Gm-Message-State: AOAM532ArLUv37HFWD6/VABAvZbrm+a+Nk8+dIWVUj3/wR1dc/2ValR3
	Jn61cjvi1C23hJRuLxzwm11Th/jMVZTNDixt7fU=
X-Google-Smtp-Source: ABdhPJwYWGMbclmwDPrzhIdtYuAsHL0pBriCjWfc2hCTs0HV6XFMbr9gLGyVz5hxtMKOnzK9eqg9Ik2Y2dsSseaHi6s=
X-Received: by 2002:a05:6512:1191:: with SMTP id g17mr19069368lfr.87.1617099626974;
 Tue, 30 Mar 2021 03:20:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:c110:0:b029:c5:4d7c:6f12 with HTTP; Tue, 30 Mar 2021
 03:20:26 -0700 (PDT)
From: Katherine Rafael <vickyomenka@gmail.com>
Date: Tue, 30 Mar 2021 11:20:26 +0100
Message-ID: <CAC1_g=a0=xdFEraXL8fCyMxFBBXzpA8giosm5kzyOTw4vUCzGw@mail.gmail.com>
Subject: Halo anak-anak Tuhan
To: undisclosed-recipients:;
Message-ID-Hash: WVGL7F3BX2Z2FCOADDOWEQ3TKMPUM7PA
X-Message-ID-Hash: WVGL7F3BX2Z2FCOADDOWEQ3TKMPUM7PA
X-MailFrom: vickyomenka@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: kath.rafael2020@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WVGL7F3BX2Z2FCOADDOWEQ3TKMPUM7PA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

-- 
Halo anak-anak Tuhan


Nama saya Ny. Katherine Rafael, seorang pengusaha wanita Warga Negara
Pantai Gading dan lahir 7 Oktober 1959. Saya memiliki misi untuk Anda
senilai US $ 2, 500, 000, 00 (Dua juta Lima ratus ribu dolar Amerika
Serikat negara bagian) yang saya maksudkan gunakan untuk amal.

Saya seorang wanita penderita kanker payudara dan telah diberitahu
oleh dokter bahwa saya akan mati dalam waktu yang tidak lama lagi,
sekarang dan ingin menyumbangkan uang ini untuk amal melalui Anda
dengan mentransfer uang ini ke rekening Anda, agar orang-orang di
daerah Anda mendapat manfaat darinya. Bisakah Anda menjadi orang yang
akan saya gunakan dalam transaksi mulia ini sebelum saya pergi untuk
operasi saya?

Nyonya Katherine Rafael,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
