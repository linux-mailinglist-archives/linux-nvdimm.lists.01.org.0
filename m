Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E58701F215A
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Jun 2020 23:12:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 02DCF100AA7B8;
	Mon,  8 Jun 2020 14:12:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A5A3100AA7B8
	for <linux-nvdimm@lists.01.org>; Mon,  8 Jun 2020 14:12:37 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058L1PAr073146;
	Mon, 8 Jun 2020 17:12:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31hrn7qy5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2020 17:12:13 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 058L1w9C076021;
	Mon, 8 Jun 2020 17:12:13 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31hrn7qy52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2020 17:12:13 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 058LAg5k022062;
	Mon, 8 Jun 2020 21:12:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma05fra.de.ibm.com with ESMTP id 31g2s7sw43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2020 21:12:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 058LC8pi58851502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2020 21:12:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ABBD52059;
	Mon,  8 Jun 2020 21:12:08 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.74.153])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 353065204F;
	Mon,  8 Jun 2020 21:12:03 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Tue, 09 Jun 2020 02:42:02 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 6/6] powerpc/papr_scm: Implement support for PAPR_PDSM_HEALTH
Date: Tue,  9 Jun 2020 02:40:26 +0530
Message-Id: <20200608211026.67573-7-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608211026.67573-1-vaibhav@linux.ibm.com>
References: <20200608211026.67573-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_17:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 cotscore=-2147483648 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080144
Message-ID-Hash: LC2WUGTZHVJ6CYYZ3D3OVYU2ELBZA4PD
X-Message-ID-Hash: LC2WUGTZHVJ6CYYZ3D3OVYU2ELBZA4PD
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LC2WUGTZHVJ6CYYZ3D3OVYU2ELBZA4PD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch implements support for PDSM request 'PAPR_PDSM_HEALTH'
that returns a newly introduced 'struct nd_papr_pdsm_health' instance
containing dimm health information back to user space in response to
ND_CMD_CALL. This functionality is implemented in newly introduced
papr_pdsm_health() that queries the nvdimm health information and
then copies this information to the package payload whose layout is
defined by 'struct nd_papr_pdsm_health'.

Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v11..v12:
* Minor: Reodered the initialization of 'struct nd_papr_pdsm_health'
  fields to match order present in its definition. [ Ira ]
* Added ack from Ira

v10..v11:
* Changed the definition of 'struct nd_papr_pdsm_health' to a maximal
  struct 184 bytes in size [ Dan Williams ]
* Added new field 'extension_flags' to 'struct nd_papr_pdsm_health'
  [ Dan Williams ]
* Updated papr_pdsm_health() to set field 'extension_flags' to 0.
* Introduced a define ND_PDSM_PAYLOAD_MAX_SIZE that indicates the
  maximum size of a payload.
* Fixed a suspicious conversion from u64 to u8 in papr_pdsm_health
  that was preventing correct initialization of 'struct
  nd_papr_pdsm_health'. [ Ira ]

v9..v10:
* Removed code in papr_pdsm_health that performed validation on pdsm
  payload version and corrosponding struct and defines used for
  validation of payload version.
* Dropped usage of struct papr_pdsm_health in 'struct
  papr_scm_priv'. Instead papr_psdm_health() now uses
  'papr_scm_priv.health_bitmap' to populate the pdsm payload.
* Above change also fixes the problem where this patch was removing
  the code that was previously introduced in this patch-series.
  [ Ira ]
* Introduced a new def ND_PDSM_ENVELOPE_HDR_SIZE that indicates the
  space allocated to 'struct nd_pdsm_cmd_pkg' fields except 'struct
  nd_cmd_pkg'. This def is useful in validating payload sizes.
* Reworked papr_pdsm_health() to enforce a specific payload size for
  'PAPR_PDSM_HEALTH' pdsm request.

Resend:
* Added ack from Aneesh.

v8..v9:
* s/PAPR_SCM_PDSM_HEALTH/PAPR_PDSM_HEALTH/g  [ Dan , Aneesh ]
* s/PAPR_SCM_PSDM_DIMM_*/PAPR_PDSM_DIMM_*/g
* Renamed papr_scm_get_health() to papr_psdm_health()
* Updated patch description to replace papr-scm dimm with nvdimm.

v7..v8:
* None

Resend:
* None

v6..v7:
* Updated flags_show() to use seq_buf_printf(). [Mpe]
* Updated papr_scm_get_health() to use newly introduced
  __drc_pmem_query_health() bypassing the cache [Mpe].

v5..v6:
* Added attribute '__packed' to 'struct nd_papr_pdsm_health_v1' to
  gaurd against possibility of different compilers adding different
  paddings to the struct [ Dan Williams ]

* Updated 'struct nd_papr_pdsm_health_v1' to use __u8 instead of
  'bool' and also updated drc_pmem_query_health() to take this into
  account. [ Dan Williams ]

v4..v5:
* None

v3..v4:
* Call the DSM_PAPR_SCM_HEALTH service function from
  papr_scm_service_dsm() instead of papr_scm_ndctl(). [Aneesh]

v2..v3:
* Updated struct nd_papr_scm_dimm_health_stat_v1 to use '__xx' types
  as its exported to the userspace [Aneesh]
* Changed the constants DSM_PAPR_SCM_DIMM_XX indicating dimm health
  from enum to #defines [Aneesh]

v1..v2:
* New patch in the series
---
 arch/powerpc/include/uapi/asm/papr_pdsm.h | 43 ++++++++++++++
 arch/powerpc/platforms/pseries/papr_scm.c | 71 +++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/papr_pdsm.h b/arch/powerpc/include/uapi/asm/papr_pdsm.h
index 34d1a41d2406..d453baea13c4 100644
--- a/arch/powerpc/include/uapi/asm/papr_pdsm.h
+++ b/arch/powerpc/include/uapi/asm/papr_pdsm.h
@@ -70,13 +70,56 @@ struct nd_pdsm_cmd_pkg {
 	__u8 payload[];		/* In/Out: Sub-cmd data buffer */
 } __packed;
 
+/* Calculate size used by the pdsm header fields minus 'struct nd_cmd_pkg' */
+#define ND_PDSM_HDR_SIZE \
+	(sizeof(struct nd_pdsm_cmd_pkg) - sizeof(struct nd_cmd_pkg))
+
+/* Max payload size that we can handle */
+#define ND_PDSM_PAYLOAD_MAX_SIZE 184
+
 /*
  * Methods to be embedded in ND_CMD_CALL request. These are sent to the kernel
  * via 'nd_pdsm_cmd_pkg.hdr.nd_command' member of the ioctl struct
  */
 enum papr_pdsm {
 	PAPR_PDSM_MIN = 0x0,
+	PAPR_PDSM_HEALTH,
 	PAPR_PDSM_MAX,
 };
 
+/* Various nvdimm health indicators */
+#define PAPR_PDSM_DIMM_HEALTHY       0
+#define PAPR_PDSM_DIMM_UNHEALTHY     1
+#define PAPR_PDSM_DIMM_CRITICAL      2
+#define PAPR_PDSM_DIMM_FATAL         3
+
+/*
+ * Struct exchanged between kernel & ndctl in for PAPR_PDSM_HEALTH
+ * Various flags indicate the health status of the dimm.
+ *
+ * extension_flags	: Any extension fields present in the struct.
+ * dimm_unarmed		: Dimm not armed. So contents wont persist.
+ * dimm_bad_shutdown	: Previous shutdown did not persist contents.
+ * dimm_bad_restore	: Contents from previous shutdown werent restored.
+ * dimm_scrubbed	: Contents of the dimm have been scrubbed.
+ * dimm_locked		: Contents of the dimm cant be modified until CEC reboot
+ * dimm_encrypted	: Contents of dimm are encrypted.
+ * dimm_health		: Dimm health indicator. One of PAPR_PDSM_DIMM_XXXX
+ */
+struct nd_papr_pdsm_health {
+	union {
+		struct {
+			__u32 extension_flags;
+			__u8 dimm_unarmed;
+			__u8 dimm_bad_shutdown;
+			__u8 dimm_bad_restore;
+			__u8 dimm_scrubbed;
+			__u8 dimm_locked;
+			__u8 dimm_encrypted;
+			__u16 dimm_health;
+		};
+		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
+	};
+} __packed;
+
 #endif /* _UAPI_ASM_POWERPC_PAPR_PDSM_H_ */
diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 167fcf0e249d..c7f1420f835f 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -436,6 +436,73 @@ static int is_cmd_valid(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 	return 0;
 }
 
+/* Fetch the DIMM health info and populate it in provided package. */
+static int papr_pdsm_health(struct papr_scm_priv *p,
+			    struct nd_pdsm_cmd_pkg *pkg)
+{
+	int rc;
+	struct nd_papr_pdsm_health health = { 0 };
+	u16 copysize = sizeof(struct nd_papr_pdsm_health);
+	u16 payload_size = pkg->hdr.nd_size_out - ND_PDSM_HDR_SIZE;
+
+	/* Ensure correct payload size that can hold struct nd_papr_pdsm_health */
+	if (payload_size != copysize) {
+		dev_dbg(&p->pdev->dev,
+			"Unexpected payload-size (%u). Expected (%u)",
+			pkg->hdr.nd_size_out, copysize);
+		rc = -ENOSPC;
+		goto out;
+	}
+
+	/* Ensure dimm health mutex is taken preventing concurrent access */
+	rc = mutex_lock_interruptible(&p->health_mutex);
+	if (rc)
+		goto out;
+
+	/* Always fetch upto date dimm health data ignoring cached values */
+	rc = __drc_pmem_query_health(p);
+	if (rc) {
+		mutex_unlock(&p->health_mutex);
+		goto out;
+	}
+
+	/* update health struct with various flags derived from health bitmap */
+	health = (struct nd_papr_pdsm_health) {
+		.extension_flags = 0,
+		.dimm_unarmed = !!(p->health_bitmap & PAPR_PMEM_UNARMED_MASK),
+		.dimm_bad_shutdown = !!(p->health_bitmap & PAPR_PMEM_BAD_SHUTDOWN_MASK),
+		.dimm_bad_restore = !!(p->health_bitmap & PAPR_PMEM_BAD_RESTORE_MASK),
+		.dimm_scrubbed = !!(p->health_bitmap & PAPR_PMEM_SCRUBBED_AND_LOCKED),
+		.dimm_locked = !!(p->health_bitmap & PAPR_PMEM_SCRUBBED_AND_LOCKED),
+		.dimm_encrypted = !!(p->health_bitmap & PAPR_PMEM_ENCRYPTED),
+		.dimm_health = PAPR_PDSM_DIMM_HEALTHY,
+	};
+
+	/* Update field dimm_health based on health_bitmap flags */
+	if (p->health_bitmap & PAPR_PMEM_HEALTH_FATAL)
+		health.dimm_health = PAPR_PDSM_DIMM_FATAL;
+	else if (p->health_bitmap & PAPR_PMEM_HEALTH_CRITICAL)
+		health.dimm_health = PAPR_PDSM_DIMM_CRITICAL;
+	else if (p->health_bitmap & PAPR_PMEM_HEALTH_UNHEALTHY)
+		health.dimm_health = PAPR_PDSM_DIMM_UNHEALTHY;
+
+	/* struct populated hence can release the mutex now */
+	mutex_unlock(&p->health_mutex);
+
+	dev_dbg(&p->pdev->dev, "Copying payload size=%u\n", copysize);
+
+	/* Copy the health struct to the payload */
+	memcpy(pdsm_cmd_to_payload(pkg), &health, copysize);
+
+	/* Update fw size including size of struct nd_pdsm_cmd_pkg fields */
+	pkg->hdr.nd_fw_size = copysize + ND_PDSM_HDR_SIZE;
+
+out:
+	dev_dbg(&p->pdev->dev, "completion code = %d\n", rc);
+
+	return rc;
+}
+
 /*
  * For a given pdsm request call an appropriate service function.
  * Returns errors if any while handling the pdsm command package.
@@ -449,6 +516,10 @@ static int papr_scm_service_pdsm(struct papr_scm_priv *p,
 
 	/* Call pdsm service function */
 	switch (pdsm) {
+	case PAPR_PDSM_HEALTH:
+		pkg->cmd_status = papr_pdsm_health(p, pkg);
+		break;
+
 	default:
 		dev_dbg(&p->pdev->dev, "PDSM[0x%x]: Unsupported PDSM request\n",
 			pdsm);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
