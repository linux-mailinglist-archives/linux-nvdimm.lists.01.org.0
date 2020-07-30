Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9945F2337C7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jul 2020 19:37:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF5AD12763CFD;
	Thu, 30 Jul 2020 10:37:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=jhoanaradanas@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 53F2E12763CF9
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jul 2020 10:37:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k20so6937419wmi.5
        for <linux-nvdimm@lists.01.org>; Thu, 30 Jul 2020 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Eblrlq8YvgONuKgIKjyWuTE5jN8f68vsWvImRMCe8O4=;
        b=RutCBPXkgMt4uFojFp9/nA4YeOltBlj8POCuevHDbHufdOR/YwahYPsdJeCLyIAZ38
         LGGg41fkiEZKzQp/WxAzBAgBuOt+SoYs6fcPs6v7mhOIaVqdtPH/OFDtj+UZT2INmFMN
         LZFy5EQN2DShuzKrqilPNoRIKcA0k7hDmJJ/XV27Vv2CVQJyeChVGyKxZWVrQzpoep1j
         /oYB6aE7TbJBWAgXIKRkxpqIwOnJBVmganZEh588+OkPrMei+t6K1+HmbMz0TefIqE00
         RHVcWnLMC2p43kLA+RMoeYPTgWKvpbM4GGnu163xc9hRqfM9vvWAePQUWT3Kvcf82MAp
         /s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Eblrlq8YvgONuKgIKjyWuTE5jN8f68vsWvImRMCe8O4=;
        b=EGtFm03tHeuMv2fqdMqynygst216Xh9yDkSqlzI/Buwa6OnvqkueCutWAwd49MFC7z
         pwGhuXWpPhswiH8SnXdlHcyWv2KgfF4TTXFWfIMwG/7F944IRm8QZ7oqdMnGd0iCjlq2
         AISNYJgndJl4/FUWbBdvZ58tHnHYM3ESKkSNd9png2GIzolgOcsoKWPIqPSfVlhqpWKp
         /tGlnlAZcKcH+z42c7XqDaDVjRXV/TDBUdMNTxyMglNvlgmHOIQmCQAuzKIhJrSs+MMS
         lqcAcdN4ENcOkT8FqhDRiTleIQhkr/YiZ5XV2YPTK5oXPQrFBzQigWODfOvRlIYZIZZ7
         l5rQ==
X-Gm-Message-State: AOAM533xsnfvxjCEUvUdHCBUV7ZBPN49Jj9JZoGN5wjxUp83zafjn3Xd
	ws2XhlyPf+/dsOf1W3BsP77g4ckxL8VFhr9TfGYNcg==
X-Google-Smtp-Source: ABdhPJzNkqtMJjqPL6w38PcgCjbCqeOyh7F8WcEEu1dBu3l78kxs5wlkPeEDsvHRcy1oVrw9DZ997fysCqWLjIzC7RI=
X-Received: by 2002:a7b:c306:: with SMTP id k6mr340636wmj.86.1596130664600;
 Thu, 30 Jul 2020 10:37:44 -0700 (PDT)
MIME-Version: 1.0
From: Jhoan Aradanas <jhoanaradanas@gmail.com>
Date: Fri, 31 Jul 2020 01:37:30 +0800
Message-ID: <CAMvTTZqu1BJEbesPeruNhLKbc8QXMYnZBv3YKL1t+w90i-LaAA@mail.gmail.com>
Subject: 
To: linux-nvdimm@lists.01.org
Message-ID-Hash: LSD722QDTMVWGEUFQXUFKTP2MYKRKXGV
X-Message-ID-Hash: LSD722QDTMVWGEUFQXUFKTP2MYKRKXGV
X-MailFrom: jhoanaradanas@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LSD722QDTMVWGEUFQXUFKTP2MYKRKXGV/>
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
