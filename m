Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F5161EE4
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 03:19:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 004221007B189;
	Mon, 17 Feb 2020 18:22:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com; envelope-from=mamys745@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 165481007B183
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 18:22:20 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n10so20061959wrm.1
        for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 18:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y5XnPvvVhIbFiWK6ghziD4CkjO85ensK1XPtP5Gl6zQ=;
        b=eYKNXkP70pmL+XDXP+GckXbVAihve1MQ2JKjtPwH3ZzqdKl1BmQuJo5AEmZ5bg2MGA
         Sb279ta+E/XfJfZyjVVuDuGoXZbWVJYsR4HotwGZN5l7pyp8ux1v4QEf49JUORa3e7Fo
         0+S/FQFfVCItzZjRguVgyFDrGBA6GH8PNpuXWlmuMhIVuYYzkTrqcFCr1blAQz89GOHU
         0F5MuRMUxhe6DhXdTGEyz1TyPSNJH9y69pgvfWjcjToib9RsWJlup7Qjx8UDPQzZB2rX
         myGi7gbY3H8Ab+Scw2ibiTQ4zOe91hDaXJO+TqswErasJlvG72SnT6QnDcgRhZxyivps
         Tdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y5XnPvvVhIbFiWK6ghziD4CkjO85ensK1XPtP5Gl6zQ=;
        b=PBhcfVJ67lYl8r51DZEIAzArGLcN6NLzQlIHGlZBwcyCHeykrc6ZZ4+kPL9WJUmYz+
         Rg9HQD0luObHuIWOWEgBiyV4h6piM1Tl0f7quVEhHsY+1AnJo5vXlv6bE8yAFYlMFtFF
         8lxLSNGswBh+jxXrXPq61VAPhO7T+lVebx9X2L3KdA+FGd/e+lb1tBXHVmK1F4PkjCey
         nmpMP9PKOtxjzH50n7JYw9xB6+Imw03M23ywgmBG4kk7pt/Dyo0N8LI7q1u4u3T6Pa1k
         XX4B4xZPH/Z+YD1ce56GrrvyLu6QOKXmtWaKX1ClFVJ4vguGVI2V0k2SG+Hc52IqcvS+
         RtcA==
X-Gm-Message-State: APjAAAVYrQ7dYPnRaVmK9RaApBVALlMa+XeE+ZHCYXvTMi9Qc/Ab+rCa
	oFUd8UlwC2isLbrQ8nYXWof6rD++lWnGxjrxHKg=
X-Google-Smtp-Source: APXvYqyIR9XoKyr1U1gUrr9ckC5FD6tzbntx7vt2W6SLCgL7XN3Sr9u37iAo/rfuLJG8ASHDuReLgGrV8MLQRauetGw=
X-Received: by 2002:a5d:4a89:: with SMTP id o9mr24411399wrq.32.1581992341342;
 Mon, 17 Feb 2020 18:19:01 -0800 (PST)
MIME-Version: 1.0
From: Marvella Patrick <marvellapatrick1@gmail.com>
Date: Tue, 18 Feb 2020 03:18:49 +0100
Message-ID: <CALCFPMV8hPSwMtkQcxVBdRiZzp4LwZ_Lna2bqoyaf8or0edkDg@mail.gmail.com>
Subject: 
To: undisclosed-recipients:;
Message-ID-Hash: 3MNL7C4DPYVVM73OSHDYACRWWFHYJIJP
X-Message-ID-Hash: 3MNL7C4DPYVVM73OSHDYACRWWFHYJIJP
X-MailFrom: mamys745@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3MNL7C4DPYVVM73OSHDYACRWWFHYJIJP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

How are you doing today
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
